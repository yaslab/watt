//
//  PowerSourceNotification+NotifyTask.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import struct Synchronization.Mutex
import var notify.NOTIFY_STATUS_OK
import func notify.notify_cancel
import func notify.notify_register_dispatch

extension PowerSourceNotification {
    public final class NotifyTask: Sendable {
        enum State {
            case ready(Name, () -> Void)
            case running(Int32)
            case finished
            case error
        }

        private let state: Mutex<State>

        init(state: State) {
            self.state = Mutex(state)
        }

        public convenience init(for name: Name, callback: @escaping () -> Void) {
            self.init(state: .ready(name, callback))
        }

        isolated deinit {
            cancel()
        }

        public var isError: Bool {
            state.withLock { state in
                if case .error = state {
                    return true
                } else {
                    return false
                }
            }
        }

        public func start() {
            state.withLock { state in
                if case .ready(let name, let callback) = state {
                    var token: Int32 = 0

                    let status = notify_register_dispatch(name.rawValue, &token, .main) { _ in
                        callback()
                    }

                    if status == NOTIFY_STATUS_OK {
                        state = .running(token)
                    } else {
                        state = .error
                    }
                }
            }
        }

        public func cancel() {
            state.withLock { state in
                switch state {
                case .ready:
                    state = .finished

                case .running(let token):
                    notify_cancel(token)
                    state = .finished

                case .finished, .error:
                    break
                }
            }
        }
    }
}
