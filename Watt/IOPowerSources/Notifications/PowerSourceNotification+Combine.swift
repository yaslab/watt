//
//  PowerSourceNotification+Combine.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import struct Combine.AnyPublisher
import class Combine.PassthroughSubject

extension PowerSourceNotification {
    public static func publisher(for name: Name) -> AnyPublisher<Void, Never> {
        let subject = PassthroughSubject<Void, Never>()

        let task = NotifyTask(for: name) {
            subject.send()
        }

        task.start()

        if task.isError {
            subject.send(completion: .finished)
        }

        return subject.handleEvents(
            receiveCancel: { task.cancel() }
        )
        .eraseToAnyPublisher()
    }
}
