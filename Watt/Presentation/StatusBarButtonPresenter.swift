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

        cancellable = externalPowerAdapterRepository.publisher
            //.throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .replaceError(with: .empty)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.updateButton($0) }
    }

    private func updateButton(_ source: ExternalPowerAdapter) {
        guard let button = button else {
            return
        }

        let title: String

        if let wattage = source.wattage {
            title = wattage.format()
        } else {
            title = ""
        }

        button.title = title

        let imageName: String

        if source.isAdapterConnected {
            if source.batteries.contains(where: \.isCharging) {
                imageName = "bolt.fill"
            } else {
                imageName = "bolt.badge.checkmark.fill"
            }
        } else {
            imageName = "bolt.slash.fill"
        }

        button.image = NSImage(systemSymbolName: imageName, accessibilityDescription: nil)
    }
}
