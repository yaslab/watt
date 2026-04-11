//
//  Current.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/11.
//

/// The current in `mA`.
struct Current: RawRepresentable {
    let rawValue: Int
}

extension Current {
    func format() -> String {
        let current = Double(rawValue) / 1000.0
        return current.formatted(.number.precision(.fractionLength(0 ... 2))) + "A"
    }
}
