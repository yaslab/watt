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

final class MenuItem: NSMenuItem {
    private let size: NSSize

    @MainActor
    init<Content: View>(size: NSSize = NSSize(width: 300, height: 32), isHighlightEnabled: Bool = false, content: @escaping () -> Content) {
        self.size = size

        // Note: If action is nil, highlighting doesn't work, so set a dummy selector.
        super.init(title: "", action: #selector(MenuItem.onDummy), keyEquivalent: "")

        target = self

        let view = MenuItemView(isHighlightEnabled: isHighlightEnabled, content: content)
        view.setFrameSize(size)
        view.autoresizingMask = [.width, .height]
        self.view = view
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @MainActor
    override var isHidden: Bool {
        didSet {
            view?.isHidden = isHidden
            view?.setFrameSize(isHidden ? .zero : size)
        }
    }

    // MARK: - Dummy

    @objc private func onDummy() {
        assertionFailure("This method should not be called.")
    }
}

private final class EventProxy: ObservableObject {
    @Published
    var isHighlighted = false

    @Published
    var isHidden = false
}

private final class MenuItemView<Content: View>: NSView {
    private let proxy = EventProxy()

    init(isHighlightEnabled: Bool, content: @escaping () -> Content) {
        super.init(frame: .zero)

        let view = NSHostingView(rootView: MenuItemButton(proxy: proxy, isHighlightEnabled: isHighlightEnabled, content: content))

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

    override var isHidden: Bool {
        didSet {
            proxy.isHidden = isHidden
        }
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

    @ObservedObject
    var proxy: EventProxy

    let isHighlightEnabled: Bool

    let content: () -> T

    var body: some View {
        if proxy.isHidden {
            EmptyView()
        } else {
            ZStack {
                if isHighlightEnabled, proxy.isHighlighted {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.secondary)
                        .opacity(colorScheme == .light ? 0.24 : 0.4)
                }

                content()
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
            }
            .padding(.horizontal, 6)
        }
    }
}
