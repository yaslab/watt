//
//  Notification+Notify.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import struct Synchronization.Mutex
import var notify.NOTIFY_STATUS_OK
import func notify.notify_cancel
import func notify.notify_register_dispatch

extension PowerSource {
    public final class NotifyTask: Sendable {
        enum State {
            case ready(String, () -> Void)
            case running(Int32)
            case finished
            case error
        }

        private let state: Mutex<State>

        init(state: State) {
            self.state = Mutex(state)
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

                    let status = notify_register_dispatch(name, &token, .main) { _ in
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
                if case .running(let token) = state {
                    notify_cancel(token)
                    state = .finished
                }
            }
        }
    }

    public func notificationTask(name: NotificationName, callback: @escaping () -> Void) -> NotifyTask {
        return NotifyTask(state: .ready(name.rawValue, callback))
    }
}
