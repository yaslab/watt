//
//  PowerAdapterModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/13.
//

import Combine
import Dispatch
import Observation

@Observable
class PowerAdapterModel {
    private(set) var value: PowerAdapter

    @ObservationIgnored
    private var cancellables: Set<AnyCancellable> = []

    init(service: PowerAdapterService) {
        self.value = service.adapter()

        service.notifications()
            .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .map { service.adapter() }
            .assign(to: \.value, on: self)
            .store(in: &cancellables)
    }
}
