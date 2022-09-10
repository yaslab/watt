//
//  OpenSystemSettingsMenuItemPresenter.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/10.
//

import AppKit
import Combine

class OpenSystemSettingsMenuItemPresenter {
    private weak var item: NSMenuItem?

    private let launcherManager: LauncherManager

    private var cancellable: AnyCancellable?

    init(launcherManager: LauncherManager) {
        self.launcherManager = launcherManager
    }

    func attach(_ item: NSMenuItem, events: MenuEventProxy) {
        self.item = item

        cancellable = events.publisher
//            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.onEvent($0) }
    }

    private func onEvent(_ event: MenuEventProxy.Event) {
        guard let item = item else {
            return
        }

        switch event {
        case .open:
            item.isHidden = !launcherManager.isRequiresApproval
        case .close:
            break
        }
    }
}
