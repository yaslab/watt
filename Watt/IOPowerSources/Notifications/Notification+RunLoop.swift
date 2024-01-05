//
//  Notification+RunLoop.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import class CoreFoundation.CFRunLoop
import func CoreFoundation.CFRunLoopAddSource
import func CoreFoundation.CFRunLoopGetCurrent
import func CoreFoundation.CFRunLoopRemoveSource
import class CoreFoundation.CFRunLoopSource
import func IOKit.ps.IOPSCreateLimitedPowerNotification
import func IOKit.ps.IOPSNotificationCreateRunLoopSource
import typealias IOKit.ps.IOPowerSourceCallbackType

extension PowerSource {
    public class RunLoopTask {
        enum State {
            case ready(CFRunLoopSource)
            case running(CFRunLoopSource, CFRunLoop)
            case finished
            case error
        }

        // TODO: Make `state` thread safe.
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

        /// Add source to the current thread's run loop.
        ///
        /// Run loops other than the main thread are not running by default, so you need to call `CFRunLoopRun()`.
        ///
        /// - SeeAlso: [Is DispatchQueue using RunLoop?](https://stackoverflow.com/a/70791936)
        public func start() {
            if case let .ready(source) = state {
                let loop: CFRunLoop = CFRunLoopGetCurrent()
                CFRunLoopAddSource(loop, source, .defaultMode)
                state = .running(source, loop)
            }
        }

        public func cancel() {
            if case let .running(source, loop) = state {
                CFRunLoopRemoveSource(loop, source, .defaultMode)
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
