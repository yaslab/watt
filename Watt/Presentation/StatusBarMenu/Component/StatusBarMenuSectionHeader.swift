//
//  StatusBarMenuSectionHeader.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/29.
//

import SwiftUI

struct StatusBarMenuSectionHeader: View {
    private let content: String

    init(_ content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .font(.subheadline.bold())
            .foregroundStyle(.secondary)
    }
}
