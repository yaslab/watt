//
//  StatusBarMenuSectionHeader.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2025/12/29.
//

import SwiftUI

struct StatusBarMenuSectionHeader<Detail: View>: View {
    private let content: String
    private let detail: () -> Detail

    init(_ resource: LocalizedStringResource, @ViewBuilder detail: @escaping () -> Detail = { EmptyView() }) {
        self.content = String(localized: resource)
        self.detail = detail
    }

    init(_ content: String, @ViewBuilder detail: @escaping () -> Detail = { EmptyView() }) {
        self.content = content
        self.detail = detail
    }

    var body: some View {
        Text(content)
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .trailing) { detail() }
            .font(.subheadline.bold())
            .foregroundStyle(.secondary)
    }
}
