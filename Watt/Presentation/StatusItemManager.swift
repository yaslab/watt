//
//  StatusItemManager.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import AppKit

class StatusItemManager {
    private let resolver: DIResolver

    private let statusBarButtonPresenter: StatusBarButtonPresenter

    private let openSystemSettingsMenuItemPresenter: OpenSystemSettingsMenuItemPresenter

    private lazy var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    private lazy var delegate = MenuEventProxy()

    init(
        resolver: DIResolver,
        statusBarButtonPresenter: StatusBarButtonPresenter,
        openSystemSettingsMenuItemPresenter: OpenSystemSettingsMenuItemPresenter
    ) {
        self.resolver = resolver
        self.statusBarButtonPresenter = statusBarButtonPresenter
        self.openSystemSettingsMenuItemPresenter = openSystemSettingsMenuItemPresenter
    }

    func setup() {
        statusItem.menu = makeMenu()

        if let button = statusItem.button {
            button.imagePosition = .imageLeading
            statusBarButtonPresenter.attach(button)
        }
    }

    private func makeMenu() -> NSMenu {
        let menu = NSMenu()

        menu.delegate = delegate

        menu.addItem(MenuItem(
            size: NSSize(width: 300, height: 512),
            content: { [resolver] in PowerAdapterInformationView(viewModel: resolver.resolve()) }
        ))

        menu.addItem(.separator())

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
            content: { AcknowledgmentsView() }
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
}
