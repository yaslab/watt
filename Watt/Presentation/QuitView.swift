//
//  QuitView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

struct QuitView: View {
    @Environment(\.dismiss) private var dismiss

    let action: () -> Void

    var body: some View {
        Button {
            Task {
                try await Task.sleep(for: .seconds(0.25))
                action()
                dismiss()
            }
        } label: {
            Label("Quit Watt", systemImage: "xmark.rectangle")
                .statusBarMenuButton()
        }
        .buttonStyle(.plain)
        .keyboardShortcut("Q", modifiers: .command)
    }
}
