//
//  QuitView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

struct QuitView: View {
    var body: some View {
        StatusBarMenuButton("Quit Watt", systemImage: "xmark.rectangle") {
            NSApp.terminate(nil)
        }
    }
}
