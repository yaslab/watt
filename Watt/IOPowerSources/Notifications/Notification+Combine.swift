//
//  Notification+Combine.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import struct Combine.AnyPublisher
import class Combine.PassthroughSubject

extension PowerSource {
    public func notificationPublisher(name: NotificationName) -> AnyPublisher<Void, Never> {
        let subject = PassthroughSubject<Void, Never>()

        let task = notificationTask(name: name) {
            subject.send()
        }

        task.start()

        if task.isError {
            subject.send(completion: .finished)
        }

        return subject.handleEvents(
            receiveCompletion: { _ in task.cancel() },
            receiveCancel: { task.cancel() }
        )
        .eraseToAnyPublisher()
    }
}
