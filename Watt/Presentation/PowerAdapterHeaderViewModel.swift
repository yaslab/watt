//
//  PowerAdapterHeaderViewModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/12.
//

import Combine
import Foundation

class PowerAdapterHeaderViewModel: ObservableObject {
    private let externalPowerAdapterRepository: ExternalPowerAdapterRepository

    private var cancellable: AnyCancellable?

    init(externalPowerAdapterRepository: ExternalPowerAdapterRepository) {
        self.externalPowerAdapterRepository = externalPowerAdapterRepository
        isConnected = externalPowerAdapterRepository.value.isAdapterConnected
    }

    // MARK: - View States

    @Published
    private(set) var isConnected: Bool
}

// MARK: - View Events

extension PowerAdapterHeaderViewModel {
    func onAppear() {
        isConnected = externalPowerAdapterRepository.value.isAdapterConnected

        cancellable = externalPowerAdapterRepository
            .publisher
            .map(\.isAdapterConnected)
            .receive(on: DispatchQueue.main)
            .assign(to: \.isConnected, on: self)
    }

    func onDisappear() {
        cancellable = nil
    }
}
