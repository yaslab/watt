//
//  StatusBarMenuLabel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/29.
//

import SwiftUI

struct StatusBarMenuLabel: View {
    private let title: String
    private let image: () -> Image

    init(_ title: String, image: @escaping @autoclosure () -> Image) {
        self.title = title
        self.image = image
    }

    var body: some View {
        Label {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
        } icon: {
            image()
                .aspectRatio(contentMode: .fit)
                .frame(width: 16, height: 16)
        }
        //.labelIconToTitleSpacing(16) // This is only available in macOS 26.0 or newer.
        .frame(minHeight: 20)
    }
}
