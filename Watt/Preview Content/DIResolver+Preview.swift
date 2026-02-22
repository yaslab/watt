//
//  DIResolver+Preview.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

extension DIResolver {
    static func preview(
        persistenceDataSource: PersistenceStore.Source = PersistenceDataSourcePreviewImpl(),
        autoStartManager: AutoStartManager = AutoStartManagerPreviewImpl(),
        powerAdapterService: PowerAdapterService = PowerAdapterServicePreviewImpl()
    ) -> DIResolver {
        return DIResolver(
            persistenceStore: PersistenceStore(source: persistenceDataSource),
            autoStartManager: autoStartManager,
            powerAdapterService: powerAdapterService
        )
    }
}
