//
//  WattConfiguration.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/02/28.
//

import Foundation
import Observation

@Observable
class WattConfiguration {
    let projectVersion: String
    let marketingVersion: String

    init(infoDictionary: [String: Any] = Bundle.main.infoDictionary!) {
        self.projectVersion = infoDictionary["CFBundleVersion"] as! String
        self.marketingVersion = infoDictionary["CFBundleShortVersionString"] as! String
    }
}

extension WattConfiguration {
    func formattedVersion() -> String {
        return "Version \(marketingVersion) (\(projectVersion))"
    }
}
