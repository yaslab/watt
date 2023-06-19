//
//  Voltage.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2022/09/11.
//

struct Voltage: RawRepresentable {
    let rawValue: Int
}

extension Voltage {
    func format() -> String {
        String(format: "%.2f", Double(rawValue) / 1000.0) + "V"
    }
}
