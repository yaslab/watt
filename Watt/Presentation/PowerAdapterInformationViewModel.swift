//
//  PowerAdapterInformationViewModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import Combine
import Foundation

final class PowerAdapterInformationViewModel: ObservableObject {
    private var cancellable: AnyCancellable?

    init(externalPowerAdapterRepository: ExternalPowerAdapterRepository) {
        adapter = externalPowerAdapterRepository.value

        cancellable = externalPowerAdapterRepository
            .publisher
            // .throttle(for: 0.5, scheduler: DispatchQueue.main, latest: true)
            .receive(on: DispatchQueue.main)
            .assign(to: \.adapter, on: self)
    }

    // MARK: - View States

    @Published
    private(set) var adapter: ExternalPowerAdapter
}

// MARK: - View Events

extension PowerAdapterInformationViewModel {}
