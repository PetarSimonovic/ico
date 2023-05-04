//
//  ContentView.swift
//  ico
//
//  Created by Petar Simonovic on 04/05/2023.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    
    var scenekitView = ScenekitView()
    
    @State private var value = 0.0
    @State private var wire = false;

    func toggleWire() {
        wire = !wire
        scenekitView.generateIcosphere(recursions: Int(value), wireframe: wire)
              
    }

    var body: some View {
        VStack {
            scenekitView
            
            Slider(value: $value, in: 0...5, onEditingChanged: { editing in
                let recursions: Int = Int(value)
                scenekitView.generateIcosphere(recursions: recursions, wireframe: wire)
            })
            Text("Recursion \(Int(value))")
            Button(action: toggleWire) {
                Text("Wire")
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
