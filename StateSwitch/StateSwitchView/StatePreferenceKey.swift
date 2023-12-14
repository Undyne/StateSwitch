//
//  StatePreferenceKey.swift
//  StateSwitch
//
//  Created by Greg Rodrigues on 2023-12-13.
//

import SwiftUI

struct StatePreferenceKey: PreferenceKey {
    typealias Value = [StatePreferenceData]

    static var defaultValue: [StatePreferenceData] = []

    static func reduce(value: inout [StatePreferenceData], nextValue: () -> [StatePreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

struct StatePreferenceData: Equatable {
    let viewIndex: Int
    let rect: CGRect
}
