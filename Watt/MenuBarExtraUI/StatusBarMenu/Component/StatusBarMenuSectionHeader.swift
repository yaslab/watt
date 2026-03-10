//
//  StatusBarMenuSectionHeader.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/29.
//

import SwiftUI

struct StatusBarMenuSectionHeader: View {
    private let content: LocalizedStringResource
    private let detail: String?

    init(_ content: LocalizedStringResource, detail: String? = nil) {
        self.content = content
        self.detail = detail
    }

    init(_ content: String, detail: String? = nil) {
        self.content = LocalizedStringResource(stringLiteral: content)
        self.detail = detail
    }

    var body: some View {
        Text(content)
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .trailing) { Text(detail ?? "") }
            .font(.subheadline.bold())
            .foregroundStyle(.secondary)
    }
}
