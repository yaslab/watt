//
//  PowerAdapterService+Preview.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

import Combine

class PowerAdapterServicePreviewImpl: PowerAdapterService {
    private let _adapter: PowerAdapter

    init(adapter: PowerAdapter = .preview(.connected)) {
        self._adapter = adapter
    }

    func adapter() -> PowerAdapter {
        return _adapter
    }

    func notifications() -> AnyPublisher<Void, Never> {
        return Just(()).eraseToAnyPublisher()
    }
}
