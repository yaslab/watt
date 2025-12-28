//
//  DIContainer.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

let liveResolver = DIContainer()

final class DIContainer: DIResolver {
    private lazy var sharedPowerSource = PowerSource()

    private func resolve() -> PowerSource {
        return sharedPowerSource
    }

    // MARK: Client

    private lazy var sharedLauncherManager = LauncherManager(service: .mainApp)

    func resolve() -> LauncherManager {
        return sharedLauncherManager
    }

    private lazy var sharedExternalPowerAdapterRepository = ExternalPowerAdapterRepository(
        ps: resolve()
    )

    func resolve() -> ExternalPowerAdapterRepository {
        return sharedExternalPowerAdapterRepository
    }
}
