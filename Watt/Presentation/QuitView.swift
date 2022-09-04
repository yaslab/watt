//
//  QuitView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

struct QuitView: View {
    let controller: WattAppController

    var body: some View {
        Button(action: controller.onQuit) {
            Text("Quit")

            Spacer()
        }
        .buttonStyle(.borderless)
        .foregroundColor(.primary)
    }
}
