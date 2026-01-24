//
//  PowerAdapterClient.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/13.
//

import Combine

import class Dispatch.DispatchQueue
import protocol SwiftUI.EnvironmentKey
import struct SwiftUI.EnvironmentValues

final class PowerAdapterClient {
    init(ps: PowerSource) {
        func convert(_ details: ExternalPowerAdapterDetails?, _ descriptions: [PowerSourceDescription]?) -> PowerAdapter {
            PowerAdapter(
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
                batteries: descriptions?.map {
                    PowerAdapter.Battery(isCharging: $0.isCharging)
                }
            )
        }

        let subject = CurrentValueSubject<PowerAdapter, Never>(
            convert(ps.externalPowerAdapterDetails(), ps.powerSources())
        )

        self.subject = subject

        let cancellable = PowerSourceNotification.publisher(name: .any)
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .map { convert(ps.externalPowerAdapterDetails(), ps.powerSources()) }
            .sink { subject.send($0) }

        self.cancellable = cancellable
    }

    private let subject: CurrentValueSubject<PowerAdapter, Never>

    private let cancellable: AnyCancellable

    var publisher: AnyPublisher<PowerAdapter, Never> {
        subject.eraseToAnyPublisher()
    }

    var value: PowerAdapter {
        subject.value
    }
}

// MARK: - Environment

private struct _Key: EnvironmentKey {
    static var defaultValue: PowerAdapterClient = liveResolver.resolve()
}

extension EnvironmentValues {
    var powerAdapterClient: PowerAdapterClient {
        get { self[_Key.self] }
        set { self[_Key.self] = newValue }
    }
}
