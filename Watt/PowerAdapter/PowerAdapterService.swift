//
//  PowerAdapterService.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/01.
//

import Combine

protocol PowerAdapterService {
    func adapter() -> PowerAdapter
    func notifications() -> AnyPublisher<Void, Never>
}
