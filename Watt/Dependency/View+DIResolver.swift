//
//  View+DIResolver.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

import SwiftUI

extension View {
    func environment(resolver: DIResolver) -> some View {
        self.environment(resolver.resolve() as AutoStartModel)
            .environment(resolver.resolve() as PowerAdapterModel)
            .environment(resolver.resolve() as ReviewRequestModel)
    }
}
