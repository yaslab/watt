//
//  ExternalPowerAdapterRepository.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/13.
//

import Combine

final class ExternalPowerAdapterRepository {
    init(ps: PowerSource) {
        func convert(_ details: ExternalPowerAdapterDetails?, _ descriptions: [PowerSourceDescription]?) -> ExternalPowerAdapter {
            ExternalPowerAdapter(
                wattage: details?.value(forKey: .watts).map { Wattage(rawValue: $0) },
                voltage: {
                    if let voltage = details?.value(forKey: .voltage) {
                        return Voltage(rawValue: voltage)
                    }
                    if let voltage = details?.value(forKey: .adapterVoltage) {
                        return Voltage(rawValue: voltage)
                    }
                    return nil
                }(),
                current: details?.value(forKey: .current).map { Current(rawValue: $0) },
                name: details?.value(forKey: .name),
                manufacturer: details?.value(forKey: .manufacturer),
                batteries: descriptions?.map {
                    ExternalPowerAdapter.Battery(isCharging: $0.value(forKey: .isCharging))
                }
            )
        }

        let subject = CurrentValueSubject<ExternalPowerAdapter, Never>(
            convert(ps.externalPowerAdapterDetails(), ps.powerSources())
        )

        self.subject = subject

        let cancellable = ps.notificationPublisher(name: .any)
            // .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .map { convert(ps.externalPowerAdapterDetails(), ps.powerSources()) }
            .share()
            .sink { subject.send($0) }

        self.cancellable = cancellable
    }

    private let subject: CurrentValueSubject<ExternalPowerAdapter, Never>

    private let cancellable: AnyCancellable

    var publisher: AnyPublisher<ExternalPowerAdapter, Never> {
        subject.eraseToAnyPublisher()
    }

    var value: ExternalPowerAdapter {
        subject.value
    }
}
