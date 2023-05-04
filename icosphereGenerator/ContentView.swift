//
//  ContentView.swift
//  icosphereGenerator
//
//  Created by Petar Simonovic on 04/05/2023.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    
    var scenekitView = ScenekitView()
    
    @State private var value = 0.0


    var body: some View {
        VStack {
            scenekitView
        }
        VStack {
            Slider(value: $value, in: 0...10, onEditingChanged: { editing in
                let recursions: Int = Int(value)
                scenekitView.generateIcosphere(recursions: recursions)
            })
            Text("Recursion \(Int(value))")
        }

        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
