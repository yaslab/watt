//
//  PowerAdapterInformationViewModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import Combine
import Foundation

class PowerAdapterInformationViewModel: ObservableObject {
    private var cancellable: AnyCancellable?

    init(externalPowerAdapterRepository: ExternalPowerAdapterRepository) {
        updateValues(externalPowerAdapterRepository.value)

        cancellable = externalPowerAdapterRepository
            .publisher
//            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.updateValues($0) }
    }

    // MARK: - View States

    @Published
    private(set) var wattage: Wattage?

    @Published
    private(set) var voltage: Voltage?

    @Published
    private(set) var current: Current?

    @Published
    private(set) var name: String?

    @Published
    private(set) var manufacturer: String?

    @Published
    private(set) var isCharging: Bool = false

    private func updateValues(_ source: ExternalPowerAdapter) {
        wattage = source.wattage

        voltage = source.voltage

        current = source.current

        name = source.name

        manufacturer = source.manufacturer

        isCharging = source.batteries?.contains(where: \.isCharging) ?? false
    }
}

// MARK: - View Events

extension PowerAdapterInformationViewModel {}
