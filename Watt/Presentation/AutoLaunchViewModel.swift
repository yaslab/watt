//
//  AutoLaunchViewModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/29.
//

import Foundation

class AutoLaunchViewModel: ObservableObject {
    @Published
    var isEnabled: Bool

    @Published
    private(set) var isUpdating = false

    private weak var manager: LauncherManager?

    init(_ manager: LauncherManager?) {
        isEnabled = manager?.isEnabled ?? false
        self.manager = manager
    }

    func onAppear() {
        guard let manager = manager else {
            return
        }

        isEnabled = manager.isEnabled
    }

    func onIsEnabledChange(_ enabled: Bool) {
        guard let manager = manager else {
            return
        }

        if enabled == manager.isEnabled {
            return
        }

        do {
            if enabled {
                try manager.register()
            } else {
                try manager.unregister()
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
