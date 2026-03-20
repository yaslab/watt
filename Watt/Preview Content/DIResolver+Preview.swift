//
//  DIResolver+Preview.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

extension DIResolver {
    static func preview(
        infoDictionary: [String: Any] = InfoPreviewImpl.dictionary(),
        persistenceDataSource: sending PersistenceStore.Source = PersistenceDataSourcePreviewImpl(),
        autoStartManager: AutoStartManager = AutoStartManagerPreviewImpl(),
        powerAdapterService: PowerAdapterService = PowerAdapterServicePreviewImpl()
    ) -> DIResolver {
        return DIResolver(
            wattConfiguration: WattConfiguration(infoDictionary: infoDictionary),
            persistenceStore: PersistenceStore(source: persistenceDataSource),
            autoStartManager: autoStartManager,
            powerAdapterService: powerAdapterService
        )
    }
}
