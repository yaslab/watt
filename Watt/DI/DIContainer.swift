//
//  DIContainer.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

class DIContainer {
    private lazy var shared = (
        controller: WattAppController(),
        ps: PowerSource(),
        launcherManager: LauncherManager()
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
            controller: resolve(),
            ps: resolve(),
            launcherManager: resolve()
        )
    }
}
