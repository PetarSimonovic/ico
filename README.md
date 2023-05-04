# ico

An icosphere creator written in Swift, with a SwiftUI SceneKit view that demos the generated geometries.


<img width="500" alt="image" src="https://user-images.githubusercontent.com/69108995/236297763-a6f0d2f1-b2a4-4bb3-a662-58336d5409db.png">


## Usage

Ico generates the indices and vertices required to create an icosahedron or icosphere using SceneKit.

The accompanying views use that data to create the shapes. 

Ico's data could, however, be modified to create stranger geometries.

### Icosphere generation

The Ico class creates an icosahedron, a  polyhedron with 20 equilateral triangles.

It converts this into a sphere by splitting each triangle into four smaller triangles. 

This process can be repeated to create progressively smoother spheres.


```swift
func generateIcoSphere(recursions: Int = 0) 
```

```generateIcoSphere``` calculates the indices and vectors that define the icosphere geometry. 

It has a default recursions value of 0, which will produce an unrefined icosahedron.

It returns its data in an Icosphere struct, in types that coform to SceneKit's expectations for rendering geometry.

```swift
struct Icosphere {
    let indices: [Int32]
    let vertices: [SCNVector3]
}

```
## Running the demos

Ico was created as part of an iOS project and was designed so return data that could be modified before being used to create SceneKit geometries.

ScenekitView and ContentView render the data without any modification, other than allowing the level of recursion to be adjusted. 

It also adds colours and toggles between solid/wireframe to make the faces more visible. 

These views will run as an iOS app in XCode's content previews and simulators.




### sources

Fast Icosphere Mesh by Volodymyr Agafonkin
https://observablehq.com/@mourner/fast-icosphere-mesh

Creating an icosphere mesh in code by Andreas Kahler
http://blog.andreaskahler.com/2009/06/creating-icosphere-mesh-in-code.html
