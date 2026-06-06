//
//  InputEventMonitor.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/06/06.
//

import AppKit
import Combine

protocol InputEventMonitor {
    func events(matching mask: NSEvent.EventTypeMask) -> AnyPublisher<NSEvent, Never>
}
