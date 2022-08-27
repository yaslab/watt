//
//  Notification+RunLoop.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import class Foundation.Thread

import func CoreFoundation.CFRunLoopAddSource
import func CoreFoundation.CFRunLoopGetCurrent
import struct CoreFoundation.CFRunLoopMode
import func CoreFoundation.CFRunLoopRemoveSource
import class CoreFoundation.CFRunLoopSource

import typealias IOKit.ps.IOPowerSourceCallbackType
import func IOKit.ps.IOPSCreateLimitedPowerNotification
import func IOKit.ps.IOPSNotificationCreateRunLoopSource

extension PowerSource {
    public class RunLoopTask {
        enum State {
            case ready(CFRunLoopSource)
            case running(CFRunLoopSource)
            case finished
            case error
        }

        private weak var thread: Thread?

        private var state: State

        private let context: Any?

        init(state: State, context: Any?) {
            self.state = state
            self.context = context
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
            if case let .ready(source) = state {
                CFRunLoopAddSource(CFRunLoopGetCurrent(), source, CFRunLoopMode.defaultMode)
                thread = Thread.current
                state = .running(source)
            }
        }

        public func cancel() {
            if case let .running(source) = state {
                assert(Thread.current == thread)
                CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, CFRunLoopMode.defaultMode)
                state = .finished
            }
        }
    }

    public func notificationRunLoopTask(name: NotificationName, callback: @escaping () -> Void) -> RunLoopTask {
        class Context {
            let callback: () -> Void
            init(_ callback: @escaping () -> Void) {
                self.callback = callback
            }
        }

        let _callback: IOPowerSourceCallbackType = { pointer in
            let context = Unmanaged<Context>.fromOpaque(pointer!).takeUnretainedValue()
            context.callback()
        }

        let context = Context(callback)

        let pointer = Unmanaged.passUnretained(context).toOpaque()

        let source: CFRunLoopSource

        switch name {
        case .timeRemaining:
            guard let _source = IOPSNotificationCreateRunLoopSource(_callback, pointer)?.takeRetainedValue() else {
                return RunLoopTask(state: .error, context: nil)
            }
            source = _source
        case .powerSource:
            guard let _source = IOPSCreateLimitedPowerNotification(_callback, pointer)?.takeRetainedValue() else {
                return RunLoopTask(state: .error, context: nil)
            }
            source = _source
        default:
            assertionFailure("Not supported.")
            return RunLoopTask(state: .error, context: nil)
        }

        return RunLoopTask(state: .ready(source), context: context)
    }
}
