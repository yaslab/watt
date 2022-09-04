//
//  AutoLaunchView.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/08/28.
//

import SwiftUI

struct AutoLaunchView: View {
    @StateObject
    var viewModel: AutoLaunchViewModel

    var body: some View {
        HStack {
            Text("Launch at login")

            Spacer()

            ZStack {
                Switch(isOn: $viewModel.isEnabled)
                    .disabled(viewModel.isUpdating)

                if viewModel.isUpdating {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .controlSize(.small)
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
        .onChange(of: viewModel.isEnabled, perform: viewModel.onIsEnabledChange(_:))
    }
}
