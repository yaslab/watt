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

    private let title: LocalizedStringResource
    private let image: () -> Image
    private let action: () -> Void

    init(_ title: LocalizedStringResource, image: @escaping @autoclosure () -> Image, action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.action = action
    }

    init(_ title: String, image: @escaping @autoclosure () -> Image, action: @escaping () -> Void) {
        self.title = LocalizedStringResource(stringLiteral: title)
        self.image = image
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
            StatusBarMenuLabel(title, image: image())
                .background {
                    if isHovering {
                        //ConcentricRectangle(corners: .concentric(minimum: 10))
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
