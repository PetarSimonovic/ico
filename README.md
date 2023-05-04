# ico

An icosphere creator written in Swift, with a SwiftUI SceneKit view that renders the generated geometries.

## Usage

The ico class generates creates an icosahedron, a  polyhedron with 20 equilateral triangles.

It converts this into a sphere by splitting each triangle into four smaller triangles. 

This process can be repeated to create a smoother sphere.

```swift
func generateIcoSphere(recursions: Int = 0) 
```

The core generator returns an Icosphere struct that contains the data for the vertices and indeces of the shape. These can be used to create stranger, irregular geometries.





### sources

Fast Icosphere Mesh by Volodymyr Agafonkin
https://observablehq.com/@mourner/fast-icosphere-mesh

Creating an icosphere mesh in code by Andreas Kahler
http://blog.andreaskahler.com/2009/06/creating-icosphere-mesh-in-code.html
