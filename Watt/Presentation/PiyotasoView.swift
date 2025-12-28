//
//  PiyotasoView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/30.
//

import SwiftUI

struct PiyotasoView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.openURL) private var openURL

    var body: some View {
        Button {
            Task {
                try await Task.sleep(for: .seconds(0.25))
                openURL(URL(string: "https://hiyokoyarou.com/")!)
                dismiss()
            }
        } label: {
            Label("Illustration of app icon by ぴよたそ", systemImage: "link")
                .statusBarMenuButton()
        }
        .buttonStyle(.plain)
    }
}
