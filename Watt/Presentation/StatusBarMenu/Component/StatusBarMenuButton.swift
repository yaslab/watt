//
//  StatusBarMenuButton.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import SwiftUI

struct StatusBarMenuButton: View {
    @Environment(\.dismiss) private var dismiss

    @State private var isHovering: Bool = false
    @State private var isAwaitingDismiss: Bool = false

    private let title: String
    private let systemImage: String
    private let action: () -> Void

    init(_ title: String, systemImage: String, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }

    var body: some View {
        Button {
            if isAwaitingDismiss { return }
            isAwaitingDismiss = true
            Task {
                try await Task.sleep(for: .seconds(0.3))
                dismiss()
                action()
                try await Task.sleep(for: .seconds(1.0))
                isAwaitingDismiss = false
            }
        } label: {
            StatusBarMenuLabel(title, systemImage: systemImage)
                .frame(minHeight: 20)
                .background {
                    if isHovering {
                        //ConcentricRectangle(corners: .concentric(minimum: 10))
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.fill.opacity(0.5))
                            .padding(.horizontal, -8)
                    }
                }
                .onHover {
                    isHovering = $0
                }
        }
        .buttonStyle(.plain)
    }
}
