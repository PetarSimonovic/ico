# ico

An icosphere creator written in Swift, with a SwiftUI SceneKit view that demos the generated geometries.


<img width="500" alt="image" src="https://user-images.githubusercontent.com/69108995/236297763-a6f0d2f1-b2a4-4bb3-a662-58336d5409db.png">


## How to use

Ico generates the indices and vertices required to create an icosahedron or icosphere.

It returns the indices as [Int32] and the vertices as [SCNVector3] so the values can be plugged straight into SceneKit's geometry tools.

Ico's data could, however, be translated into other formats or modified to create stranger geometries.

The accompanying views use that data to create the shapes in a sample iOS app. 


### Icosphere generation

The Ico class creates an icosahedron, a  polyhedron with 20 equilateral triangles.

It converts this into a sphere by splitting each triangle into four smaller triangles. 

This process can be repeated to create progressively smoother spheres.


```swift
func generateIcoSphere(recursions: Int = 0) 
```

```generateIcoSphere``` calculates the indices and vectors that define the icosphere geometry. 

It has a default recursions value of 0, which will produce an unrefined icosahedron.

It returns its data in an Icosphere struct, in types that are compatible with SceneKit.

```swift
struct Icosphere {
    let indices: [Int32]
    let vertices: [SCNVector3]
}

```
## Running the demos

Ico was created as part of an iOS project and was designed to return data that could be modified before being used to create SceneKit geometries.

ScenekitView and ContentView render the data without any modification, other than allowing the level of recursion to be adjusted. 

The views also add colours and allow toggling between solid/wireframe shapes to make the faces more visible. 

These views run as an iOS app in XCode's content previews and simulators.



### Sources

**Fast Icosphere Mesh** by Volodymyr Agafonkin
https://observablehq.com/@mourner/fast-icosphere-mesh

**Creating an icosphere mesh in code** by Andreas Kahler
http://blog.andreaskahler.com/2009/06/creating-icosphere-mesh-in-code.html

**Gradient Meshes in SceneKit** by MovingParts
https://movingparts.io/gradient-meshes

**Custom Geometry in SceneKit** by Mike Lucking
https://betterprogramming.pub/custom-geometry-in-scenekit-under-swiftui-35a95520e6d9
