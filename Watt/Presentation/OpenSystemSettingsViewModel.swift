//
//  OpenSystemSettingsViewModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/10.
//

import Foundation

final class OpenSystemSettingsViewModel: ObservableObject {
    private let launcherManager: LauncherManager

    init(launcherManager: LauncherManager) {
        self.launcherManager = launcherManager
    }

    // MARK: - View States
}

// MARK: - View Events

extension OpenSystemSettingsViewModel {
    func onClick() {
        launcherManager.openSystemSettingsLoginItems()
    }
}
