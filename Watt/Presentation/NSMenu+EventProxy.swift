//
//  NSMenu+EventProxy.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/10.
//

import AppKit
import Combine

class MenuEventProxy: NSObject, NSMenuDelegate {
    enum Event {
        case open
        case close
    }

    private let subject = PassthroughSubject<Event, Never>()

    var publisher: AnyPublisher<Event, Never> {
        subject.eraseToAnyPublisher()
    }

    // MARK: - Handling Open and Close Events

    @MainActor
    func menuWillOpen(_ menu: NSMenu) {
        subject.send(.open)
    }

    @MainActor
    func menuDidClose(_ menu: NSMenu) {
        subject.send(.close)
    }
}
