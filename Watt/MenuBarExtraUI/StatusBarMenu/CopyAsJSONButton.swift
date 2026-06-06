//
//  CopyAsJSONButton.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/06/06.
//

import SwiftUI

struct CopyAsJSONButton: View {
    let dictionary: NSDictionary

    @State private var isDisabled: Bool = false
    @State private var tempText: LocalizedStringResource?

    var body: some View {
        Button {
            isDisabled = true

            do {
                let json = try JSONSerialization.data(
                    withJSONObject: dictionary,
                    options: [.prettyPrinted, .sortedKeys]
                )

                NSPasteboard.general.clearContents()
                NSPasteboard.general.setData(json, forType: .string)

                tempText = .menuJsonCopied
            } catch {
                tempText = .menuJsonCopyFailed
            }

            Task {
                try? await Task.sleep(for: .seconds(2))

                isDisabled = false
                tempText = nil
            }
        } label: {
            Text(tempText ?? .menuCopyAsJson)
        }
        .buttonStyle(.bordered)
        .controlSize(.mini)
        .disabled(isDisabled)
    }
}
