//
//  DIContainer.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

import ServiceManagement

class DIContainer {
    private lazy var shared = (
        controller: WattAppController(),
        ps: PowerSource(),
        launcherManager: LauncherManagerHelper.resolve()
    )

    private func resolve() -> PowerSource {
        shared.ps
    }

    private func resolve() -> LauncherManager {
        shared.launcherManager
    }

    func resolve() -> StatusItemManager {
        StatusItemManager(
            resolver: self,
            statusBarButtonPresenter: resolve(),
            openSystemSettingsMenuItemPresenter: resolve()
        )
    }
}

extension DIContainer: DIResolver {
    // MARK: View Model

    func resolve() -> PowerAdapterInformationViewModel {
        PowerAdapterInformationViewModel(
            ps: resolve()
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
            ps: resolve()
        )
    }

    func resolve() -> OpenSystemSettingsMenuItemPresenter {
        OpenSystemSettingsMenuItemPresenter(
            launcherManager: resolve()
        )
    }
}
