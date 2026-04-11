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
    private func convert(
        details: ExternalPowerAdapterDetails?,
        descriptions: [PowerSourceDescription]?
    ) -> PowerAdapter {
        return PowerAdapter(
            wattage: details?.watts.map { Wattage(rawValue: $0) },
            voltage: details?.voltage.map { Voltage(rawValue: $0) },
            current: details?.current.map { Current(rawValue: $0) },
            name: details?.name?.trimmingCharacters(in: .whitespaces),
            manufacturer: details?.manufacturer?.trimmingCharacters(in: .whitespaces),
            sources: descriptions?.map { description in
                PowerAdapter.PowerSource(
                    id: description.powerSourceID,
                    state: description.powerSourceState,
                    voltage: description.voltage.map { Voltage(rawValue: $0) },
                    current: description.current.map { Current(rawValue: $0) },
                    batteryHealth: description.batteryHealth,
                    batteryCurrentCapacity: description.currentCapacity,
                    batteryTimeToEmpty: description.timeToEmpty.map { TimeInMinutes(rawValue: $0) },
                    batteryTimeToFullCharge: description.timeToFullCharge.map { TimeInMinutes(rawValue: $0) },
                    isBatteryCharging: description.isCharging
                )
            } ?? []
        )
    }

    func adapter() -> PowerAdapter {
        return convert(
            details: PowerSource.externalPowerAdapterDetails(),
            descriptions: PowerSource.powerSources()
        )
    }

    func notifications() -> AnyPublisher<Void, Never> {
        return PowerSourceNotification.publisher(name: .any)
    }
}
