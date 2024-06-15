//
//  NSSwitch+SwiftUI.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import Combine
import SwiftUI

private let stateKey = "state"

struct Switch: NSViewRepresentable {
    @Binding
    var isOn: Bool

    func makeNSView(context: Context) -> NSSwitch {
        let view = _Switch()
        view.isOn = isOn
        view.addObserver(view, forKeyPath: stateKey, options: [.new], context: nil)
        view.callback = { isOn = $0 }
        return view
    }

    func updateNSView(_ view: NSSwitch, context: Context) {
        let view = view as! _Switch
        if view.isOn != isOn {
            Task { @MainActor in
                view.animator().isOn = isOn
            }
        }
    }
}

private final class _Switch: NSSwitch {
    var callback: ((Bool) -> Void)?

    var isOn: Bool {
        get { state != .off }
        set { state = newValue ? .on : .off }
    }

    // See: https://stackoverflow.com/q/39944383
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == stateKey, let change = change, let newValue = change[.newKey] as? NSControl.StateValue {
            Task { @MainActor in
                callback?(newValue != .off)
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}
