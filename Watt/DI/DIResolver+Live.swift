//
//  DIResolver+Live.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

extension DIResolver {
    static func live() -> DIResolver {
        return DIResolver(
            autoStartManager: AutoStartManagerLiveImpl(),
            powerAdapterService: PowerAdapterServiceLiveImpl()
        )
    }
}
