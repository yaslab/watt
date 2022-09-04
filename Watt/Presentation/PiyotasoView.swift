//
//  PiyotasoView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/30.
//

import SwiftUI

struct PiyotasoView: View {
    @Environment(\.openURL)
    private var openURL

    var body: some View {
        Button(action: { openURL(URL(string: "https://hiyokoyarou.com/")!) }) {
            Text("Illustration of app icon by ぴよたそ")

            Spacer()
        }
        .buttonStyle(.borderless)
        .foregroundColor(.primary)
    }
}
