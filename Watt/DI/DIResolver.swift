//
//  DIResolver.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

class DIResolver {
    init(
        autoStartManager: AutoStartManager,
        powerAdapterService: PowerAdapterService
    ) {
        self.sharedAutoStartModel = AutoStartModel(
            manager: autoStartManager
        )
        self.sharedPowerAdapterModel = PowerAdapterModel(
            service: powerAdapterService
        )
    }

    // MARK: Model

    private let sharedAutoStartModel: AutoStartModel

    func resolve() -> AutoStartModel {
        return sharedAutoStartModel
    }

    private let sharedPowerAdapterModel: PowerAdapterModel

    func resolve() -> PowerAdapterModel {
        return sharedPowerAdapterModel
    }
}
