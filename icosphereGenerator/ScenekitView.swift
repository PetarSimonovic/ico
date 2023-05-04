//
//  ScenekitView.swift
//  ico
//
//  Created by Petar Simonovic on 04/05/2023.
//

import Foundation
import SwiftUI
import SceneKit

struct ScenekitView: UIViewRepresentable {
    
    
    let scene = SCNScene()
    let scnView = SCNView()

    let ico: Ico = Ico()

    
    func makeUIView(context: Context) -> SCNView {
        
        generateIcosphere()
        
        let cameraNode: SCNNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3Make(0, 5, 0)
        
        createAmbientLight()
        createOmniLight()
        
        return scnView

       
    }

    func updateUIView(_ scnView: SCNView, context: Context) {
        
        scnView.scene = scene

        
        scnView.allowsCameraControl = true


        scnView.backgroundColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.61)
    }
    
    func generateIcosphere(recursions: Int = 0, wireframe: Bool = false) {
        
        
        if let node = scene.rootNode.childNode(withName: "icosphere", recursively: false) {
            node.removeFromParentNode()
        }
        let icosphereData: Icosphere = ico.generateIcoSphere(recursions: recursions)
        let icosphere: SCNNode = createGeometry(icosphere: icosphereData)
        icosphere.name = "icosphere"
        if wireframe {
            icosphere.geometry?.firstMaterial?.fillMode = .lines
        }
        scene.rootNode.addChildNode(icosphere)
    }
 
    func createGeometry(icosphere: Icosphere) -> SCNNode {
        
        let elements: SCNGeometryElement = SCNGeometryElement(
            indices: icosphere.indices,
            primitiveType: .triangles
            
        )
        
        let vertices: SCNGeometrySource = SCNGeometrySource(vertices: icosphere.vertices)
        
        let colors: SCNGeometrySource = SCNGeometrySource(colors: icosphere.vertices)

        let geometry: SCNGeometry = SCNGeometry(
            sources: [vertices, colors],
            elements: [elements]
        )
        
        let icoSphereNode: SCNNode = SCNNode(geometry: geometry)
        
        
        return icoSphereNode
        
    }
    
   
    
    func createAmbientLight() {
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        scene.rootNode.addChildNode(ambientLightNode)
    }
    
    func createOmniLight() {
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light!.type = SCNLight.LightType.omni
        omniLightNode.light!.color = UIColor(white: 0.75, alpha: 1.0)
        omniLightNode.position = SCNVector3Make(0, 0, -3)
        scene.rootNode.addChildNode(omniLightNode)
    }

}

public extension SCNGeometrySource {
    /// Initializes a `SCNGeometrySource` with a list of colors as
    /// `SCNVector3`s`.
    convenience init(colors: [SCNVector3]) {
        let colorData = Data(bytes: colors, count: MemoryLayout<SCNVector3>.size * colors.count)
        
        self.init(
            data: colorData,
            semantic: .color,
            vectorCount: colors.count,
            usesFloatComponents: true,
            componentsPerVector: 3,
            bytesPerComponent: MemoryLayout<Float>.size,
            dataOffset: 0,
            dataStride: MemoryLayout<SCNVector3>.size
        )
    }
    
}
