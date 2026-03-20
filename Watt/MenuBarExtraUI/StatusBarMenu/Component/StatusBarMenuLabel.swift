//
//  StatusBarMenuLabel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/29.
//

import SwiftUI

struct StatusBarMenuLabel<Icon: View>: View {
    private let title: String
    private let icon: () -> Icon

    init(_ resource: LocalizedStringResource, icon: @escaping () -> Icon) {
        self.title = String(localized: resource)
        self.icon = icon

    }

    init(_ title: String, icon: @escaping () -> Icon) {
        self.title = title
        self.icon = icon
    }

    var body: some View {
        Label {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
        } icon: {
            icon()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
        }
        //.labelIconToTitleSpacing(16) // This is only available in macOS 26.0 or newer.
        .frame(minHeight: 20)
    }
}
