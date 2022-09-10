//
//  OpenSystemSettingsViewModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/10.
//

import Foundation

class OpenSystemSettingsViewModel: ObservableObject {
    private let launcherManager: LauncherManager

    init(launcherManager: LauncherManager) {
        self.launcherManager = launcherManager
    }

    // MARK: - View States
}

// MARK: - View Events

extension OpenSystemSettingsViewModel {
    func onClick() {
        type(of: launcherManager)
            .openSystemSettingsLoginItems()
    }
}
