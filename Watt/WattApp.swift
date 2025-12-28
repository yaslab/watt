//
//  WattApp.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/27.
//

import SwiftUI

@main
struct WattApp: App {
    var body: some Scene {
        MenuBarExtra {
            StatusBarMenu()
        } label: {
            StatusBarButton()
        }
        .menuBarExtraStyle(.window)
    }
}
