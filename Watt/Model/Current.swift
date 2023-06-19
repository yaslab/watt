//
//  Current.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/11.
//

struct Current: RawRepresentable {
    let rawValue: Int
}

extension Current {
    func format() -> String {
        String(format: "%.2f", Double(rawValue) / 1000.0) + "A"
    }
}
