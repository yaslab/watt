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
    func resolve() -> AutoLaunchViewModel
    func resolve() -> OpenSystemSettingsViewModel

    // MARK: Controller

    func resolve() -> WattAppController

    // MARK: Presenter

    func resolve() -> StatusBarButtonPresenter
    func resolve() -> OpenSystemSettingsMenuItemPresenter
}
