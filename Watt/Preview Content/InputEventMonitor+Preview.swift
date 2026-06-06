//
//  InputEventMonitor+Preview.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/06/06.
//

import AppKit
import Combine

class InputEventMonitorPreviewImpl: InputEventMonitor {
    private let isOptionKeyPressed: Bool

    init(isOptionKeyPressed: Bool = false) {
        self.isOptionKeyPressed = isOptionKeyPressed
    }

    func events(matching mask: NSEvent.EventTypeMask) -> AnyPublisher<NSEvent, Never> {
        Just(
            .keyEvent(
                with: .flagsChanged,
                location: .zero,
                modifierFlags: isOptionKeyPressed ? .option : [],
                timestamp: ProcessInfo.processInfo.systemUptime,
                windowNumber: 0,
                context: nil,
                characters: "",
                charactersIgnoringModifiers: "",
                isARepeat: false,
                keyCode: 0
            )!
        )
        .eraseToAnyPublisher()
    }
}
