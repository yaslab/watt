//
//  StatusBarButtonPresenter.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

import AppKit
import Combine

@MainActor
final class StatusBarButtonPresenter {
    private weak var button: NSStatusBarButton?

    private let externalPowerAdapterRepository: ExternalPowerAdapterRepository

    private var cancellable: AnyCancellable?

    init(externalPowerAdapterRepository: ExternalPowerAdapterRepository) {
        self.externalPowerAdapterRepository = externalPowerAdapterRepository
    }

    func attach(_ button: NSStatusBarButton?) {
        self.button = button

        updateButton(externalPowerAdapterRepository.value)

        cancellable = externalPowerAdapterRepository
            .publisher
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.updateButton($0) }
    }

    private func updateButton(_ source: ExternalPowerAdapter) {
        guard let button = button else {
            return
        }

        var title = ""

        if let wattage = source.wattage {
            title = wattage.format()
        }

        button.title = title

        var imageName = "bolt.slash.fill"

        if let batteries = source.batteries, batteries.contains(where: \.isCharging) {
            imageName = "bolt.fill"
        }

        button.image = NSImage(systemSymbolName: imageName, accessibilityDescription: nil)
    }
}
