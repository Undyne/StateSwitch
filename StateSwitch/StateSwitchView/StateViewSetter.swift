//
//  StateViewSetter.swift
//  StateSwitch
//
//  Created by Greg Rodrigues on 2023-12-13.
//

import SwiftUI

struct StateViewSetter: View {
    let index: Int

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: StatePreferenceKey.self,
                            value: [StatePreferenceData(viewIndex: self.index,
                                                        rect: geometry.frame(
                                                            in: .named("myZstack")
                                                        ))])
        }
    }
}
