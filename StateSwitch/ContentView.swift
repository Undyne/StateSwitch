//
//  ContentView.swift
//  StateSwitch
//
//  Created by Greg Rodrigues on 2023-12-13.
//

import SwiftUI

struct ContentView: View {
    
    @State var isSecond: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(isSecond ? "Hello, world!" : "Goodbye, world!")
            StateSwitchView(isSecond: $isSecond,
                            leftSide: "Left",
                            rightSide:"Right",
                            activeBackground: .accentColor)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
