//
//  PowerAdapterService.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

import Combine

protocol PowerAdapterService {
    func adapter() -> PowerAdapter
    func notifications() -> AnyPublisher<Void, Never>
}

class PowerAdapterServiceLiveImpl: PowerAdapterService {
    private let ps = PowerSource()

    private func convert(_ details: ExternalPowerAdapterDetails?, _ descriptions: [PowerSourceDescription]?) -> PowerAdapter {
        return PowerAdapter(
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
            name: details?.name?.trimmingCharacters(in: .whitespaces),
            manufacturer: details?.manufacturer?.trimmingCharacters(in: .whitespaces),
            sources: descriptions?.map {
                PowerAdapter.PowerSource(
                    id: $0.powerSourceID,
                    state: $0.powerSourceState,
                    batteryCurrentCapacity: $0.currentCapacity,
                    batteryTimeToEmpty: $0.timeToEmpty.map { TimeInMinutes(rawValue: $0) },
                    batteryTimeToFullCharge: $0.timeToFullCharge.map { TimeInMinutes(rawValue: $0) },
                    isBatteryCharging: $0.isCharging
                )
            } ?? []
        )
    }

    func adapter() -> PowerAdapter {
        return convert(ps.externalPowerAdapterDetails(), ps.powerSources())
    }

    func notifications() -> AnyPublisher<Void, Never> {
        return PowerSourceNotification.publisher(name: .any)
    }
}
