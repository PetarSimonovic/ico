//
//  ScenekitView.swift
//  icosphereGenerator
//
//  Created by Petar Simonovic on 04/05/2023.
//

import Foundation
import SwiftUI
import SceneKit

struct ScenekitView: UIViewRepresentable {
    
    
    let scene = SCNScene()
    let scnView = SCNView()

    let icosphereGenerator: IcosphereGenerator = IcosphereGenerator()

    
    func makeUIView(context: Context) -> SCNView {
        
        generateIcosphere()
        let cameraNode: SCNNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 5, 0)

        // Create Lights
        
        createAmbientLight()
        createOmniLight()
        
        
        return scnView

       
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
        
        // updates the scnView with the scene
        scnView.scene = scene

        // allows the user to manipulate the camera
        
        scnView.allowsCameraControl = true


        // configure the view
        scnView.backgroundColor = UIColor(red: 0.1, green: 0.3, blue: 0.56, alpha: 0.61)
    }
    
    func generateIcosphere(recursions: Int = 0) {
        
        print("In scenekitscene")
        
        if let node = scene.rootNode.childNode(withName: "icosphere", recursively: false) {
            print("removing node")
            node.removeFromParentNode()
        }
        let icosphereData: Icosphere = icosphereGenerator.generateIcoSphere(recursions: recursions)
        let icosphere: SCNNode = createGeometry(icosphere: icosphereData)
        icosphere.name = "icosphere"
        scene.rootNode.addChildNode(icosphere)
    }
 
    func createGeometry(icosphere: Icosphere) -> SCNNode {
        
        let elements: SCNGeometryElement = SCNGeometryElement(
            indices: icosphere.indices,
            primitiveType: .triangles
            
        )
        
        let vertices: SCNGeometrySource = SCNGeometrySource(vertices: icosphere.vertices)
        
        let geometry: SCNGeometry = SCNGeometry(
            sources: [vertices],
            elements: [elements] // COLOURS HERE!!!
        )
        
        let icoSphereNode: SCNNode = SCNNode(geometry: geometry)
        
        
        return icoSphereNode
        
    }
 
    
    
    func createAmbientLight() {
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
    }
    
    func createOmniLight() {
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLight.LightType.omni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 50, 50)
        scene.rootNode.addChildNode(omniLightNode)
    }

}
