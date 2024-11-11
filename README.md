# EineKleine3DRendererView

A library for rendering 3D models using [EineKleine3DRenderer](https://github.com/trenskow/EineKleine3DRenderer) in SwiftUI.

# Usage

````swift
import EineKleine3DRendererView

struct TeaPot: View {
  
  @State private var renderer = Renderer()
  
  init() {
    try! self.renderer.load(objectFile: "teapot.obj")
  }
  
  var body: some View {
    EineKleine3DRendererView(
      renderer: self.renderer,
      camera: .pointsAtTarget(
        position: Vertex3d(x: 2.5, y: 0, z: 0),
        target: .zero))
  }
  
}
````

# License

See license in LICENSE.

