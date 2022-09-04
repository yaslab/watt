//
//  ViewModelResolver.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/04.
//

protocol ViewModelResolver {
    func resolve() -> PowerAdapterInformationViewModel
    func resolve() -> AutoLaunchViewModel

    func resolve() -> StatusBarButtonPresenter
}
