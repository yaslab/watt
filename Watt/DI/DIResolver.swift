//
//  DIResolver.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

protocol DIResolver {
    // MARK: Client

    func resolve() -> LauncherManager
    func resolve() -> ExternalPowerAdapterRepository
}
