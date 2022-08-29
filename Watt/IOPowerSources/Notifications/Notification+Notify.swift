//
//  Notification+Notify.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import class Dispatch.DispatchQueue

import func notify.notify_cancel
import func notify.notify_register_dispatch
import var notify.NOTIFY_STATUS_OK

private let _queue = DispatchQueue(label: "net.yaslab.IOPowerSource.Notify")

extension PowerSource {
    public class NotifyTask {
        enum State {
            case ready(String, DispatchQueue, () -> Void)
            case running(Int32)
            case finished
            case error
        }

        private var state: State

        init(state: State) {
            self.state = state
        }

        deinit {
            cancel()
        }

        public var isError: Bool {
            if case .error = state {
                return true
            } else {
                return false
            }
        }

        public func start() {
            if case let .ready(name, queue, callback) = state {
                var token: Int32 = 0

                let status = notify_register_dispatch(name, &token, queue) { _ in
                    callback()
                }

                if status == NOTIFY_STATUS_OK {
                    state = .running(token)
                } else {
                    state = .error
                }
            }
        }

        public func cancel() {
            if case let .running(token) = state {
                notify_cancel(token)
                state = .finished
            }
        }
    }

    public func notificationTask(name: NotificationName, queue: DispatchQueue? = nil, callback: @escaping () -> Void) -> NotifyTask {
        return NotifyTask(state: .ready(name.rawValue, queue ?? _queue, callback))
    }
}
