//
//  StatusBarButtonPresenter.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

import AppKit
import Combine

class StatusBarButtonPresenter {
    private weak var button: NSStatusBarButton?

    private let ps: PowerSource

    private var cancellable: AnyCancellable?

    init(ps: PowerSource) {
        self.ps = ps
    }

    func attach(_ button: NSStatusBarButton?) {
        self.button = button

        updateButton()

        subscribePowerSourceEvents()
    }

    private func updateButton() {
        guard let button = button else {
            return
        }

        var title = ""

        if let details = ps.externalPowerAdapterDetails {
            if let watts = details.value(forKey: .watts) {
                title = "\(watts)W"
            }
        }

        button.title = title

        var imageName = "bolt.slash.fill"

        if let sources = ps.powerSources() {
            if sources.contains(where: { $0.value(forKey: .isCharging) }) {
                imageName = "bolt.fill"
            }
        }

        button.image = NSImage(systemSymbolName: imageName, accessibilityDescription: nil)
    }

    private func subscribePowerSourceEvents() {
        cancellable = ps.notificationPublisher(name: .any)
            .throttle(for: 2.0, scheduler: DispatchQueue.main, latest: true)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.updateButton() }
    }
}
