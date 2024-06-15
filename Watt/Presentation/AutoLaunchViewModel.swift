//
//  AutoLaunchViewModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/29.
//

import Foundation

@MainActor
final class AutoLaunchViewModel: ObservableObject {
    private let launcherManager: LauncherManager

    init(launcherManager: LauncherManager) {
        self.launcherManager = launcherManager
        isEnabled = launcherManager.isEnabled
    }

    // MARK: - View States

    @Published
    var isEnabled: Bool

    @Published
    private(set) var isUpdating = false
}

// MARK: - View Events

extension AutoLaunchViewModel {
    func onAppear() {
        isEnabled = launcherManager.isEnabled
    }

    func onIsEnabledChange(_ enabled: Bool) {
        if enabled == launcherManager.isEnabled {
            return
        }

        do {
            if enabled {
                try launcherManager.register()
            } else {
                try launcherManager.unregister()
            }
        } catch {
            isUpdating = true

            Task { @MainActor in
                try await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)

                isEnabled = !enabled

                isUpdating = false
            }
        }
    }
}
