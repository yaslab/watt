//
//  ExternalPowerAdapterRepository.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/13.
//

import Combine
import IOPowerSources
import Foundation

final class ExternalPowerAdapterRepository {
    init() {
        publisher = IOPowerSources.publisher(for: .any)
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .map { Self.convert(IOPowerSources.externalPowerAdapterDetails, IOPowerSources.sources) }
            .share()
            .eraseToAnyPublisher()
    }

    let publisher: AnyPublisher<ExternalPowerAdapter, IOPowerSources.NotifyError>

    var value: ExternalPowerAdapter {
        Self.convert(IOPowerSources.externalPowerAdapterDetails, IOPowerSources.sources)
    }
    
    private static func convert(_ details: IOPowerSources.PowerAdapter?, _ descriptions: [IOPowerSources.PowerSource]) -> ExternalPowerAdapter {
        ExternalPowerAdapter(
            wattage: details?.watts.map { Wattage(rawValue: $0) },
            voltage: {
                if let voltage = details?.voltage {
                    return Voltage(rawValue: voltage)
                }
                if let voltage = details?.adapterVoltage {
                    return Voltage(rawValue: voltage)
                }
                return nil
            }(),
            current: details?.current.map { Current(rawValue: $0) },
            name: details?.name,
            manufacturer: details?.manufacturer,
            batteries: descriptions.map {
                ExternalPowerAdapter.Battery(isCharging: $0.isCharging)
            }
        )
    }
}
