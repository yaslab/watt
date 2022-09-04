//
//  StatusItemManager.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import AppKit
import Combine

class StatusItemManager {
    private let controller: WattAppController

    private let ps: PowerSource

    private let launcherManager: LauncherManager

    private lazy var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    private var cancellable: AnyCancellable?

    init(controller: WattAppController, ps: PowerSource, launcherManager: LauncherManager) {
        self.controller = controller
        self.ps = ps
        self.launcherManager = launcherManager
    }

    func setup() {
        statusItem.menu = makeMenu()

        if let button = statusItem.button {
            button.imagePosition = .imageLeading
        }

        updateButton()

        subscribePowerSourceEvents()
    }

    private func makeMenu() -> NSMenu {
        let menu = NSMenu()

        let infoViewModel = PowerAdapterInformationViewModel(ps)
        menu.addItem(NSMenuItem(
            size: NSSize(width: 256, height: 512),
            content: { PowerAdapterInformationView(viewModel: infoViewModel) }
        ))

        menu.addItem(.separator())

        let autoLaunchViewModel = AutoLaunchViewModel(launcherManager)
        menu.addItem(NSMenuItem(
            content: { AutoLaunchView(viewModel: autoLaunchViewModel) }
        ))

        menu.addItem(.separator())

        menu.addItem(NSMenuItem(
            content: { AcknowledgmentsView() }
        ))

        menu.addItem(NSMenuItem(
            action: { NSWorkspace.shared.open(URL(string: "https://hiyokoyarou.com/")!) },
            content: { PiyotasoView() }
        ))

        menu.addItem(.separator())

        menu.addItem(NSMenuItem(
            action: { [weak controller] in controller?.onQuit() },
            content: { QuitView() }
        ))

        return menu
    }

    private func updateButton() {
        guard let button = statusItem.button else {
            return
        }

        var title = ""

        if let details = ps.externalPowerAdapterDetails {
            if let watts = details.value(forKey: .watts) {
                title = "\(watts)W"
            }
        }

        button.title = title

        var imageName = "bolt.slash.fill"

        if let sources = ps.powerSources() {
            if sources.contains(where: { $0.value(forKey: .isCharging) }) {
                imageName = "bolt.fill"
            }
        }

        button.image = NSImage(systemSymbolName: imageName, accessibilityDescription: nil)
    }

    private func subscribePowerSourceEvents() {
        cancellable = ps.notificationPublisher(name: .any)
            .throttle(for: 2.0, scheduler: DispatchQueue.main, latest: true)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.updateButton() }
    }
}
