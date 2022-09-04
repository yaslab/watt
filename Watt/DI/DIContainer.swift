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

    func resolve() -> WattAppController {
        shared.controller
    }

    private func resolve() -> PowerSource {
        shared.ps
    }

    private func resolve() -> LauncherManager {
        shared.launcherManager
    }

    func resolve() -> StatusItemManager {
        StatusItemManager(
            resolver: self,
            controller: resolve(),
            presenter: resolve()
        )
    }
}

extension DIContainer: ViewModelResolver {
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

    func resolve() -> StatusBarButtonPresenter {
        StatusBarButtonPresenter(
            ps: resolve()
        )
    }
}
