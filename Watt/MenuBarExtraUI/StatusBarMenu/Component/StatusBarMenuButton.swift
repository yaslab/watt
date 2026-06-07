//
//  StatusBarMenuButton.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import SwiftUI

struct StatusBarMenuButton<Icon: View>: View {
    @Environment(\.dismiss) private var dismiss

    @State private var isHovering: Bool = false
    @State private var isAwaitingDismiss: Bool = false

    private let title: String
    private let icon: () -> Icon
    private let action: () -> Void

    init(_ resource: LocalizedStringResource, icon: @escaping () -> Icon, action: @escaping () -> Void) {
        self.title = String(localized: resource)
        self.icon = icon
        self.action = action
    }

    init(_ title: String, icon: @escaping () -> Icon, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button {
            if isAwaitingDismiss { return }
            isAwaitingDismiss = true

            Task {
                try? await Task.sleep(for: .seconds(0.2))

                dismiss()
                action()

                try? await Task.sleep(for: .seconds(1.0))

                isAwaitingDismiss = false
            }
        } label: {
            StatusBarMenuLabel(title, icon: icon)
                .background {
                    if isHovering {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.fill.opacity(0.5))
                            .padding(.horizontal, -8)
                            .padding(.vertical, -2)
                    }
                }
                .onHover {
                    isHovering = $0
                }
        }
        .buttonStyle(.plain)
    }
}
