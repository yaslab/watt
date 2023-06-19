//
//  SectionHeader.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/30.
//

import SwiftUI

struct SectionHeader: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)

            Spacer()
        }
        .font(.callout.bold())
        .foregroundColor(.secondary)
    }
}
