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
    @State private var task: Task<Void, Never>?

    var body: some View {
        Button {
            isDisabled = true

            task = Task {
                do {
                    try await copyToPasteboard(dictionary)
                    tempText = .menuJsonCopied
                } catch {
                    tempText = .menuJsonCopyFailed
                }

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
        .onDisappear {
            task?.cancel()
        }
    }
}

extension CopyAsJSONButton {
    private func copyToPasteboard(_ dictionary: sending NSDictionary) async throws {
        let task = Task.detached {
            let json = try JSONSerialization.data(
                withJSONObject: dictionary,
                options: [.prettyPrinted, .sortedKeys]
            )
            let jsonString = String(decoding: json, as: UTF8.self)

            let pasteboard: NSPasteboard = .general
            pasteboard.clearContents()
            pasteboard.setString(jsonString, forType: .string)
        }

        try await task.value
    }
}
