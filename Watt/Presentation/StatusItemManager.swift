//
//  StatusItemManager.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import AppKit
import Combine

class StatusItemManager {
    private let resolver: DIResolver

    private let statusBarButtonPresenter: StatusBarButtonPresenter

    private let powerAdapterInformationPresenter: PowerAdapterInformationPresenter

    private let openSystemSettingsMenuItemPresenter: OpenSystemSettingsMenuItemPresenter

    private lazy var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    private lazy var delegate = MenuEventProxy()

    private var cancellable: AnyCancellable?

    init(
        resolver: DIResolver,
        statusBarButtonPresenter: StatusBarButtonPresenter,
        powerAdapterInformationPresenter: PowerAdapterInformationPresenter,
        openSystemSettingsMenuItemPresenter: OpenSystemSettingsMenuItemPresenter
    ) {
        self.resolver = resolver
        self.statusBarButtonPresenter = statusBarButtonPresenter
        self.powerAdapterInformationPresenter = powerAdapterInformationPresenter
        self.openSystemSettingsMenuItemPresenter = openSystemSettingsMenuItemPresenter
    }

    func setup() {
        statusItem.menu = makeMenu()

        if let button = statusItem.button {
            button.imagePosition = .imageLeading
            statusBarButtonPresenter.attach(button)
        }

        cancellable = delegate.publisher
//            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.onMenuEvent($0) }
    }

    private func makeMenu() -> NSMenu {
        let menu = NSMenu()

        menu.delegate = delegate

        menu.addItem(MenuItem(
            content: { [resolver] in PowerAdapterHeaderView(viewModel: resolver.resolve()) }
        ))

        menu.addItem({
            let item = MenuItem(
                size: NSSize(width: 300, height: 512),
                content: { [resolver] in PowerAdapterInformationView(viewModel: resolver.resolve()) }
            )
            powerAdapterInformationPresenter.attach(item, events: delegate)
            return item
        }())

        menu.addItem(.separator())

        menu.addItem(MenuItem(
            content: { SectionHeader(title: "Settings") }
        ))

        menu.addItem(MenuItem(
            content: { [resolver] in AutoLaunchView(viewModel: resolver.resolve()) }
        ))

        menu.addItem({
            let item = MenuItem(
                isHighlightEnabled: true,
                content: { [resolver] in OpenSystemSettingsView(viewModel: resolver.resolve()) }
            )
            openSystemSettingsMenuItemPresenter.attach(item, events: delegate)
            return item
        }())

        menu.addItem(.separator())

        menu.addItem(MenuItem(
            content: { SectionHeader(title: "Acknowledgments") }
        ))

        menu.addItem(MenuItem(
            isHighlightEnabled: true,
            content: { PiyotasoView() }
        ))

        menu.addItem(.separator())

        menu.addItem(MenuItem(
            isHighlightEnabled: true,
            content: { [resolver] in QuitView(controller: resolver.resolve()) }
        ))

        return menu
    }

    private func onMenuEvent(_ event: MenuEventProxy.Event) {
        guard let menu = statusItem.menu else {
            return
        }

        switch event {
        case .open:
            break
        case .close:
            for item in menu.items {
                // Note: Fit `NSMenuItem` size to content size.
                item.isHidden = item.isHidden
            }
        }
    }
}
