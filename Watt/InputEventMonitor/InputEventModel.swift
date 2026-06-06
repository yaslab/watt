//
//  InputEventModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/06/06.
//

import AppKit
import Combine
import Observation

@Observable
class InputEventModel {
    private let monitor: InputEventMonitor

    private(set) var isOptionKeyPressed: Bool = false
    private var cancellables: Set<AnyCancellable> = []

    init(monitor: InputEventMonitor) {
        self.monitor = monitor

        monitor.events(matching: .flagsChanged)
            .map { $0.modifierFlags.contains(.option) }
            .assign(to: \.isOptionKeyPressed, on: self)
            .store(in: &cancellables)
    }
}
