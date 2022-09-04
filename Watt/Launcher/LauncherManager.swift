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

    private func legacyGetEnabled() -> Bool {
        guard let jobs = SMCopyAllJobDictionaries(kSMDomainUserLaunchd)?.takeRetainedValue() else {
            return false
        }

        for i in 0 ..< CFArrayGetCount(jobs) {
            let job = jobs.get(at: i, as: CFDictionary.self)

            guard
                let label = job.get(forKey: "Label", as: CFString.self),
                case .compareEqualTo = CFStringCompare(label, launcherApp.id as CFString, [])
            else {
                continue
            }

            let onDemand = job.get(forKey: "OnDemand", as: CFBoolean.self)
            return CFBooleanGetValue(onDemand ?? kCFBooleanFalse)
        }

        return false
    }

    private func legacySetEnabled(_ enabled: Bool) throws {
        guard SMLoginItemSetEnabled(launcherApp.id as CFString, enabled) else {
            throw NSError(domain: "", code: -1)
        }
    }
}

extension CFArray {
    fileprivate func get<T: CFTypeRef>(at index: CFIndex, as type: T.Type) -> T {
        let value = CFArrayGetValueAtIndex(self, index)!
        return Unmanaged<T>.fromOpaque(value).takeUnretainedValue()
    }
}

extension CFDictionary {
    fileprivate func get<T: CFTypeRef>(forKey key: String, as type: T.Type) -> T? {
        let key = Unmanaged<CFString>.passUnretained(key as CFString)
        guard let value = CFDictionaryGetValue(self, key.toOpaque()) else {
            return nil
        }
        return Unmanaged<T>.fromOpaque(value).takeUnretainedValue()
    }
}
