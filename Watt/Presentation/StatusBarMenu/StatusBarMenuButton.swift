//
//  StatusBarMenuButton.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/28.
//

import SwiftUI

extension View {
    func statusBarMenuButton() -> some View {
        modifier(StatusBarMenuButton())
    }
}

private struct StatusBarMenuButton: ViewModifier {
    @State private var isHovering: Bool = false

    func body(content: Content) -> some View {
        content
            .foregroundStyle(.primary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 20)
            .background {
                if isHovering {
                    //ConcentricRectangle(corners: .concentric(minimum: 10))
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.fill)
                }
            }
            .onHover {
                isHovering = $0
            }
    }
}
