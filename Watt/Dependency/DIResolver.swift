//
//  DIResolver.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

class DIResolver {
    init(
        wattConfiguration: WattConfiguration,
        terminator: Terminator,
        persistenceStore: PersistenceStore,
        autoStartManager: AutoStartManager,
        powerAdapterService: PowerAdapterService,
        inputEventMonitor: InputEventMonitor
    ) {
        self.sharedWattConfiguration = wattConfiguration
        self.sharedTerminatorModel = TerminatorModel(
            terminator: terminator
        )
        self.sharedAutoStartModel = AutoStartModel(
            persistenceStore: persistenceStore,
            manager: autoStartManager
        )
        self.sharedPowerAdapterModel = PowerAdapterModel(
            service: powerAdapterService
        )
        self.sharedReviewRequestModel = ReviewRequestModel(
            persistenceStore: persistenceStore
        )
        self.sharedInputEventModel = InputEventModel(
            monitor: inputEventMonitor
        )
    }

    // MARK: Configuration

    private let sharedWattConfiguration: WattConfiguration

    func resolve() -> WattConfiguration {
        return sharedWattConfiguration
    }

    // MARK: Model

    private let sharedTerminatorModel: TerminatorModel

    func resolve() -> TerminatorModel {
        return sharedTerminatorModel
    }

    private let sharedAutoStartModel: AutoStartModel

    func resolve() -> AutoStartModel {
        return sharedAutoStartModel
    }

    private let sharedPowerAdapterModel: PowerAdapterModel

    func resolve() -> PowerAdapterModel {
        return sharedPowerAdapterModel
    }

    private let sharedReviewRequestModel: ReviewRequestModel

    func resolve() -> ReviewRequestModel {
        return sharedReviewRequestModel
    }

    private let sharedInputEventModel: InputEventModel

    func resolve() -> InputEventModel {
        return sharedInputEventModel
    }
}
