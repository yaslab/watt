//
//  DIResolver+Live.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

extension DIResolver {
    static func live() -> DIResolver {
        return DIResolver(
            persistenceStore: PersistenceStore(source: UserDefaultsDataSource()),
            autoStartManager: AutoStartManagerLiveImpl(),
            powerAdapterService: PowerAdapterServiceLiveImpl()
        )
    }
}
