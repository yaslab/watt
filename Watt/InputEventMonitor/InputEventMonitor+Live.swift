//
//  InputEventMonitor+Live.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/06/06.
//

import AppKit
import Combine

class InputEventMonitorLiveImpl: InputEventMonitor {
    private var monitors: [(Any?, PassthroughSubject<NSEvent, Never>)] = []

    isolated deinit {
        for (monitor, subject) in monitors {
            if let monitor { NSEvent.removeMonitor(monitor) }
            subject.send(completion: .finished)
        }
    }

    var currentModifierFlags: NSEvent.ModifierFlags {
        return NSEvent.modifierFlags
    }

    func events(matching mask: NSEvent.EventTypeMask) -> AnyPublisher<NSEvent, Never> {
        let subject = PassthroughSubject<NSEvent, Never>()
        let monitor = NSEvent.addLocalMonitorForEvents(matching: mask) { event in
            subject.send(event)
            return event
        }
        monitors.append((monitor, subject))
        return subject.eraseToAnyPublisher()
    }
}
