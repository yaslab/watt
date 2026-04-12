//
//  QuitView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

struct QuitView: View {
    @Environment(TerminatorModel.self) private var terminatorModel

    var body: some View {
        StatusBarMenuButton(.menuQuitWatt, icon: { Image(systemName: "xmark.rectangle") }) {
            terminatorModel.terminate()
        }
    }
}
