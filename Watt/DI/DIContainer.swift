//
//  DIContainer.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

private class SharedObjects {
    let controller: WattAppController

    let launcherManager: any LauncherManager

    let externalPowerAdapterRepository: ExternalPowerAdapterRepository

    init() {
        controller = WattAppController()

        launcherManager = LauncherManagerHelper.resolve()

        let ps = PowerSource()
        externalPowerAdapterRepository = ExternalPowerAdapterRepository(
            ps: ps
        )
    }
}

class DIContainer {
    private lazy var shared = SharedObjects()

    private func resolve() -> any LauncherManager {
        shared.launcherManager
    }

    func resolve() -> StatusItemManager {
        StatusItemManager(
            resolver: self,
            statusBarButtonPresenter: resolve(),
            powerAdapterInformationPresenter: resolve(),
            openSystemSettingsMenuItemPresenter: resolve()
        )
    }

    func resolve() -> ExternalPowerAdapterRepository {
        shared.externalPowerAdapterRepository
    }
}

extension DIContainer: DIResolver {
    // MARK: View Model

    func resolve() -> PowerAdapterHeaderViewModel {
        PowerAdapterHeaderViewModel(
            externalPowerAdapterRepository: resolve()
        )
    }

    func resolve() -> PowerAdapterInformationViewModel {
        PowerAdapterInformationViewModel(
            externalPowerAdapterRepository: resolve()
        )
    }

    func resolve() -> AutoLaunchViewModel {
        AutoLaunchViewModel(
            launcherManager: resolve()
        )
    }

    func resolve() -> OpenSystemSettingsViewModel {
        OpenSystemSettingsViewModel(
            launcherManager: resolve()
        )
    }

    // MARK: Controller

    func resolve() -> WattAppController {
        shared.controller
    }

    // MARK: Presenter

    func resolve() -> StatusBarButtonPresenter {
        StatusBarButtonPresenter(
            externalPowerAdapterRepository: resolve()
        )
    }

    func resolve() -> PowerAdapterInformationPresenter {
        PowerAdapterInformationPresenter(
            externalPowerAdapterRepository: resolve()
        )
    }

    func resolve() -> OpenSystemSettingsMenuItemPresenter {
        OpenSystemSettingsMenuItemPresenter(
            launcherManager: resolve()
        )
    }
}
