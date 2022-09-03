//
//  DIContainer.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

import Foundation

class DIContainer {
    func resolve() -> WattAppController {
        enum Static { static let shared = WattAppController() }
        return Static.shared
    }

    private func resolve() -> PowerSource {
        enum Static { static let shared = PowerSource() }
        return Static.shared
    }

    private func resolve() -> LauncherManager {
        enum Static { static let shared = LauncherManager() }
        return Static.shared
    }

    func resolve() -> StatusItemManager {
        StatusItemManager(resolve(), resolve(), resolve())
    }
}
