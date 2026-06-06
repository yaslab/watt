//
//  CopyAsJSONButton.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/06/06.
//

import SwiftUI

struct CopyAsJSONButton: View {
    let dictionary: NSDictionary

    var body: some View {
        Button {
            do {
                let json = try JSONSerialization.data(
                    withJSONObject: dictionary,
                    options: [.prettyPrinted, .sortedKeys]
                )

                NSPasteboard.general.clearContents()
                NSPasteboard.general.setData(json, forType: .string)
            } catch {
                // TODO: error
            }
        } label: {
            Text(.menuCopyAsJSON)
        }
        .buttonStyle(.bordered)
        .controlSize(.mini)
    }
}
