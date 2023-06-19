//
//  Wattage.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/11.
//

struct Wattage: RawRepresentable {
    let rawValue: Int
}

extension Wattage {
    func format() -> String {
        "\(rawValue)W"
    }
}
