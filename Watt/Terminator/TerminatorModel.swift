//
//  TerminatorModel.swift
//  Watt
//
//  Created by Yasuhiro Hatta on 2026/04/12.
//

import Foundation

@Observable
class TerminatorModel {
    private let terminator: Terminator

    init(terminator: Terminator) {
        self.terminator = terminator
    }

    func terminate() {
        terminator.terminate()
    }
}
