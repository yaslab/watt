//
//  GitHubView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/22.
//

import SwiftUI

struct GitHubView: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        StatusBarMenuButton(.menuViewOnGitHub, icon: { Image(.gitHubInvertocat).resizable() }) {
            openURL(URL(string: "https://github.com/yaslab/watt")!)
        }
    }
}
