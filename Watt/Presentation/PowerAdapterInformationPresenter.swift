//
//  PowerAdapterInformationPresenter.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/12/10.
//

import AppKit
import Combine

class PowerAdapterInformationPresenter {
    private weak var item: NSMenuItem?

    private let externalPowerAdapterRepository: ExternalPowerAdapterRepository

    private var cancellable: AnyCancellable?

    init(externalPowerAdapterRepository: ExternalPowerAdapterRepository) {
        self.externalPowerAdapterRepository = externalPowerAdapterRepository
    }

    func attach(_ item: NSMenuItem, events: MenuEventProxy) {
        self.item = item

        cancellable = events.publisher
            // .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.onMenuEvent($0) }
    }

    private func onMenuEvent(_ event: MenuEventProxy.Event) {
        guard let item = item else {
            return
        }

        switch event {
        case .open:
            item.isHidden = !externalPowerAdapterRepository.value.isAdapterConnected
        case .close:
            break
        }
    }
}
