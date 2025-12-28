//
//  DIResolver.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

protocol DIResolver {
    // MARK: Client

    func resolve() -> LauncherClient
    func resolve() -> PowerAdapterClient
}

let liveResolver = DIResolverImpl()

final class DIResolverImpl: DIResolver {
    private lazy var sharedPowerSource = PowerSource()

    private func resolve() -> PowerSource {
        return sharedPowerSource
    }

    // MARK: Client

    private lazy var sharedLauncherClient = LauncherClient(service: .mainApp)

    func resolve() -> LauncherClient {
        return sharedLauncherClient
    }

    private lazy var sharedExternalPowerAdapterClient = PowerAdapterClient(
        ps: resolve()
    )

    func resolve() -> PowerAdapterClient {
        return sharedExternalPowerAdapterClient
    }
}
