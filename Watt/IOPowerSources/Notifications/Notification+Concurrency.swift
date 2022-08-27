//
//  Notification+Concurrency.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

// Note: There is also a way to use `AsyncPublisher` (`Publisher.values`), but it requires macOS 12 or later.

extension PowerSource {
    func notifications(name: NotificationName) -> AsyncStream<Void> {
        AsyncStream { continuation in
            let task = notificationTask(name: name) {
                continuation.yield()
            }

            continuation.onTermination = { _ in
                task.cancel()
            }

            task.start()

            if task.isError {
                continuation.finish()
            }
        }
    }
}
