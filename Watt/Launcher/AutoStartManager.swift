//
//  AutoStartManager.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

import ServiceManagement

protocol AutoStartManager {
    var status: SMAppService.Status { get }

    func register() throws
    func unregister() throws
    func openSystemSettingsLoginItems()
}
