//
//  DIResolver.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

protocol DIResolver {
    // MARK: View Model

    func resolve() -> PowerAdapterHeaderViewModel
    func resolve() -> PowerAdapterInformationViewModel
    @MainActor
    func resolve() -> AutoLaunchViewModel
    func resolve() -> OpenSystemSettingsViewModel

    // MARK: Controller

    func resolve() -> WattAppController

    // MARK: Presenter

    @MainActor
    func resolve() -> StatusBarButtonPresenter
    func resolve() -> OpenSystemSettingsMenuItemPresenter
}
