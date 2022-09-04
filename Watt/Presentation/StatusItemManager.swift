//
//  StatusItemManager.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import AppKit

class StatusItemManager {
    private let resolver: ViewModelResolver

    private let controller: WattAppController

    private let presenter: StatusBarButtonPresenter

    private lazy var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    init(resolver: ViewModelResolver, controller: WattAppController, presenter: StatusBarButtonPresenter) {
        self.resolver = resolver
        self.controller = controller
        self.presenter = presenter
    }

    func setup() {
        statusItem.menu = makeMenu()

        if let button = statusItem.button {
            button.imagePosition = .imageLeading
            presenter.assign(button)
        }
    }

    private func makeMenu() -> NSMenu {
        let menu = NSMenu()

        menu.addItem(NSMenuItem(
            size: NSSize(width: 256, height: 512),
            content: { [resolver] in PowerAdapterInformationView(viewModel: resolver.resolve()) }
        ))

        menu.addItem(.separator())

        menu.addItem(NSMenuItem(
            content: { [resolver] in AutoLaunchView(viewModel: resolver.resolve()) }
        ))

        menu.addItem(.separator())

        menu.addItem(NSMenuItem(
            content: { AcknowledgmentsView() }
        ))

        menu.addItem(NSMenuItem(
            isHighlightEnabled: true,
            content: { PiyotasoView() }
        ))

        menu.addItem(.separator())

        menu.addItem(NSMenuItem(
            isHighlightEnabled: true,
            content: { [controller] in QuitView(controller: controller) }
        ))

        return menu
    }
}
