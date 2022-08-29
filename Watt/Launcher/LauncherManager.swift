//
//  LauncherManager.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import AppKit
import ServiceManagement

class LauncherManager {
    private let launcherApp = LauncherApp()

    var isEnabled: Bool {
        legacyGetEnabled()
    }

    func register() throws {
        try legacySetEnabled(true)
    }

    func unregister() throws {
        try legacySetEnabled(false)
    }

    // MARK: - Legacy (macOS 12 and earlier)

    private let legacyLabelKey = "Label" as CFString
    private let legacyOnDemandKey = "OnDemand" as CFString

    private func legacyGetEnabled() -> Bool {
        guard let jobs = SMCopyAllJobDictionaries(kSMDomainUserLaunchd)?.takeRetainedValue() else {
            return false
        }

        let labelKey = Unmanaged<CFString>.passUnretained(legacyLabelKey)
        let onDemandKey = Unmanaged<CFString>.passUnretained(legacyOnDemandKey)

        for i in 0 ..< CFArrayGetCount(jobs) {
            let job = Unmanaged<CFDictionary>.fromOpaque(CFArrayGetValueAtIndex(jobs, i)).takeUnretainedValue()
            let label = Unmanaged<CFString>.fromOpaque(CFDictionaryGetValue(job, labelKey.toOpaque())).takeUnretainedValue()
            if case .compareEqualTo = CFStringCompare(label, launcherApp.id as CFString, []) {
                let onDemand = Unmanaged<CFBoolean>.fromOpaque(CFDictionaryGetValue(job, onDemandKey.toOpaque())).takeUnretainedValue()
                return CFBooleanGetValue(onDemand)
            }
        }

        return false
    }

    private func legacySetEnabled(_ enabled: Bool) throws {
        guard SMLoginItemSetEnabled(launcherApp.id as CFString, enabled) else {
            throw NSError(domain: "", code: -1)
        }
    }
}
