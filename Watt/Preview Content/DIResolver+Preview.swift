//
//  DIResolver+Preview.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

extension DIResolver {
    static func preview(
        autoStartManager: AutoStartManager = AutoStartManagerPreviewImpl(),
        powerAdapterService: PowerAdapterService = PowerAdapterServicePreviewImpl()
    ) -> DIResolver {
        return DIResolver(
            autoStartManager: autoStartManager,
            powerAdapterService: powerAdapterService
        )
    }
}
