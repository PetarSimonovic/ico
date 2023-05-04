//
//  IcosphereGenerator.swift
//  icosphereGenerator
//
//  Created by Petar Simonovic on 04/05/2023.
//

import Foundation
import SceneKit

struct Icosphere {
    let indices: [Int32]
    let vertices: [SCNVector3]
}

class IcosphereGenerator {
    
    var indices: [Int32] = []
    var vertices: [SCNVector3] = []
    var index: Int32 = 3
    
    func generateIcoSphere(recursions: Int = 0) -> Icosphere {
        print ("Generating!!")
        
        generateIcosahedron()
        if recursions > 0 {
            refineIcoSphere(recursions: recursions)
            vertices = normaliseVertices()
        }
        
        return Icosphere(indices: indices, vertices: vertices)
        
    }
    
    func generateIcosahedron() {
        
        indices = createIcosahedronIndices()
        vertices = createIcosahedronVertices()
        
        
    }
    
    func createIcosahedronVertices() -> [SCNVector3] {
        
        
        var vertices: [SCNVector3] = []
        
        let goldenRatio: CGFloat = (1.0 + sqrt(5.0)) / 2.0
        
        vertices.append(SCNVector3(-1,  goldenRatio,  0))
        vertices.append(SCNVector3( 1,  goldenRatio,  0))
        vertices.append(SCNVector3(-1, -goldenRatio,  0))
        vertices.append(SCNVector3( 1, -goldenRatio,  0));
        
        vertices.append(SCNVector3(0, -1,  goldenRatio));
        vertices.append(SCNVector3( 0,  1,  goldenRatio));
        vertices.append(SCNVector3(0, -1, -goldenRatio));
        vertices.append(SCNVector3( 0,  1, -goldenRatio));
        
        vertices.append(SCNVector3(goldenRatio,  0, -1));
        vertices.append(SCNVector3(goldenRatio,  0,  1));
        vertices.append(SCNVector3(-goldenRatio,  0, -1));
        vertices.append(SCNVector3(-goldenRatio,  0,  1));
        
        return vertices
    }
    
    func createIcosahedronIndices() -> [Int32] {
        
        
        let indices: [Int32] = [
            0, 11, 5,
            0, 5, 1,
            0, 1, 7,
            0, 7, 10,
            0, 10, 11,
            1, 5, 9,
            5, 11, 4,
            11, 10, 2,
            10, 7, 6,
            7, 1, 8,
            3, 9, 4,
            3, 4, 2,
            3, 2, 6,
            3, 6, 8,
            3, 8, 9,
            4, 9, 5,
            2, 4, 11,
            6, 2, 10,
            8, 6, 7,
            9, 8, 1
        ]
        
        return indices
    }
    
    func refineIcoSphere(recursions: Int) {
        
        // Subdivide the icosahedron faces recursively to create an icosphere
        for _ in 1...recursions {
            var newIndices: [Int32] = []
            
            // Stride through the indices in batches of 3 to pick out individual the vertices that form each triangle
            
            for i in stride(from: 0, to: indices.count, by: 3) {
                let v1: Int32 = indices[i]
                let v2: Int32 = indices[i + 1]
                let v3: Int32 = indices[i + 2]
                
                
                // Create the new vertices and get the indices for each vertex
                let a: Int32 = createNewVertex(a: v1, b: v2)
                let b: Int32 = createNewVertex(a: v2, b: v3)
                let c: Int32 = createNewVertex(a: v3, b: v1)

                newIndices.append(v1)
                newIndices.append(a)
                newIndices.append(c)
                newIndices.append(v2)
                newIndices.append(b)
                newIndices.append(a)
                newIndices.append(v3)
                newIndices.append(c)
                newIndices.append(b)
                newIndices.append(a)
                newIndices.append(b)
                newIndices.append(c)
            }
            indices = newIndices
        }
    }
    
        func createNewVertex(a: Int32, b: Int32) -> Int32 {
        
            //   let key: Int = getKey(a: a, b: b)
            // first check if we have it already
            
            // use the indices to get existing vertices
            let vertex1: SCNVector3 = vertices[Int(a)];
            let vertex2: SCNVector3 = vertices[Int(b)];
            
            //  Calculate the midpoint between the existing vertices to obtain the vertex for the new triangle
            let vertex3: SCNVector3 = SCNVector3(
                (vertex1.x + vertex2.x) / 2.0,
                (vertex1.y + vertex2.y) / 2.0,
                (vertex1.z + vertex2.z) / 2.0
            )
                    
            
            // store it, return index
            vertices.append(vertex3)
            return Int32(vertices.count - 1)
        }
        
        func normaliseVertices() -> [SCNVector3] {
            
            // Normalise the vertices so they are on the surface of the sphere
            
            var normalisedVertices: [SCNVector3] = []
            for vertex in vertices {
                
                let length: Float = sqrt(
                    vertex.x * vertex.x +
                    vertex.y * vertex.y +
                    vertex.z * vertex.z
                )
                normalisedVertices.append(SCNVector3(vertex.x/length, vertex.y/length, vertex.z/length))

            }
            return normalisedVertices
        }
        
        func getKey(a: Int32, b: Int32) -> Int {
            // Cantor's pairing function  takes two non-negative integers and returns a unique integer
            
            return Int((a + b) * (a + b + 1) / 2 + b)
        }
        
}


