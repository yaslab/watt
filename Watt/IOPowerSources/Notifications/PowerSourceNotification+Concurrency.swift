//
//  PowerSourceNotification+Concurrency.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/05/09.
//

extension PowerSourceNotification {
    public static func notifications(for name: Name) -> AsyncStream<Void> {
        return AsyncStream { continuation in
            let task = NotifyTask(for: name) {
                continuation.yield()
            }

            task.start()

            if task.isError {
                continuation.finish()
            }

            continuation.onTermination = { termination in
                Task { await task.cancel() }
            }
        }
    }
}
