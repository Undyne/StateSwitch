//
//  StateSwitchView.swift
//  StateSwitch
//
//  Created by Greg Rodrigues on 2023-12-13.
//

import SwiftUI

public struct StateSwitchView: View {
    @Binding var isSecond: Bool
    @State private var rects = [CGRect](repeating: CGRect(), count: 2)

    var leftSide: String
    var rightSide: String
    
    let activeColor: Color
    let inactiveColor: Color
    let activeBackground: Color
    let inactiveBackground: Color


    var activeOption: Int { isSecond ? 1 : 0 }
    var options: [String] { [leftSide, rightSide] }

    var xOffsetForIndex: CGFloat {
        var offset = CGFloat(activeOption) * 8.0

        for rect in rects[0 ..< activeOption] {
            offset += rect.width
        }

        return offset
    }

    public init(isSecond: Binding<Bool>,
                leftSide: String, rightSide: String,
                activeColor: Color = .white,
                inactiveColor: Color = Color.init(white: 0.5),
                activeBackground: Color = Color.init(white: 0.5),
                inactiveBackground: Color = Color.init(white: 0.8)
    ) {
        _isSecond = isSecond
        self.leftSide = leftSide
        self.rightSide = rightSide
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
        self.activeBackground = activeBackground
        self.inactiveBackground = inactiveBackground
    }

    public var body: some View {
        ZStack {
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(inactiveBackground)
                    .frame(width: 12.0 + rects.reduce(0.0) { value, rect in
                        value + rect.width
                    }, height: rects[activeOption].size.height + 4.0)

                Capsule()
                    .fill(activeBackground)
                    .frame(width: rects[activeOption].size.width,
                           height: max(rects[activeOption].size.height, 0.0))
                    .offset(x: xOffsetForIndex, y: 0.0)
                    .padding(2.0)
            }
            HStack {
                ForEach(0 ..< options.count, id: \.self) { index in
                    SwitchOption(isSecond: $isSecond,
                                 label: options[index],
                                 index: index,
                                 activeColor: activeColor,
                                 inactiveColor: inactiveColor)
                }
            }
        }.onPreferenceChange(StatePreferenceKey.self) { preferences in
            for p in preferences {
                self.rects[p.viewIndex] = p.rect
            }
        }
        .coordinateSpace(name: "myZStack")
        .animation(.easeInOut)
    }
}

struct SwitchOption: View {
    @Binding var isSecond: Bool
    var activeOption: Int { isSecond ? 1 : 0 }
    let label: String
    let index: Int
    let activeColor: Color
    let inactiveColor: Color

    var body: some View {
        Text(label)
            .bold()
            .padding(.vertical, 8.0)
            .padding(.horizontal, 16.0)
            .foregroundColor(index == activeOption ? activeColor : inactiveColor)
            .background(StateViewSetter(index: index))
            .onTapGesture { self.isSecond = (self.index == 1) }
            .animation(.easeIn)
    }
}

#if DEBUG

    struct StateSwitchView_Previews: PreviewProvider {
        static var previews: some View {
            StateSwitchView(
                isSecond: Binding.constant(false),
                leftSide: "Left",
                rightSide: "Right"
            )
        }
    }

#endif
