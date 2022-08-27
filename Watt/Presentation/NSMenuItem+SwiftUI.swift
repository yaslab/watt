//
//  NSMenuItem+SwiftUI.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

// References:
//
// - Views in Menu Items
//   - https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/MenuList/Articles/ViewsInMenuItems.html

extension NSMenuItem {
    convenience init<Content: View>(size: NSSize = NSSize(width: 280, height: 24), action: (() -> Void)? = nil, content: @escaping () -> Content) {
        // Note: If action is nil, highlighting doesn't work, so set a dummy selector.
        self.init(title: "", action: #selector(WattAppDelegate.onDummy), keyEquivalent: "")

        let view = MenuItemView(action: action, content: content)
        view.setFrameSize(size)
        view.autoresizingMask = [.width]
        self.view = view
    }
}

private class EventProxy: ObservableObject {
    @Published
    var isHighlighted = false
}

private class MenuItemView<Content: View>: NSView {
    private let proxy = EventProxy()

    init(action: (() -> Void)?, content: @escaping () -> Content) {
        super.init(frame: .zero)

        let view = NSHostingView(rootView: MenuItemButton(action: action, content: content, proxy: proxy))

        view.translatesAutoresizingMaskIntoConstraints = false

        addSubview(view)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: NSRect) {
        super.draw(rect)

        if let menuItem = enclosingMenuItem {
            proxy.isHighlighted = menuItem.isHighlighted
        }
    }
}

private struct MenuItemButton<T: View>: View {
    @Environment(\.colorScheme)
    private var colorScheme

    let action: (() -> Void)?

    let content: () -> T

    @ObservedObject
    var proxy: EventProxy

    var body: some View {
        Button(action: { action?() }) {
            content()
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
        }
        .buttonStyle(.borderless)
        .background(
            RoundedRectangle(cornerRadius: 4)
                .fill(backgroundColor())
                .opacity(colorScheme == .light ? 0.24 : 0.4)
        )
        .foregroundColor(.primary)
        .padding(.horizontal, 6)
    }

    private func backgroundColor() -> Color {
        if proxy.isHighlighted, action != nil {
            let nsColor = NSColor.unemphasizedSelectedContentBackgroundColor
                .withSystemEffect(.rollover)
            return Color(nsColor: nsColor)
        } else {
            return .clear
        }
    }
}
