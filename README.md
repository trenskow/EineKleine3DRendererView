# EineKleine3DRendererView

A library for rendering 3D models using [EineKleine3DRenderer](https://github.com/trenskow/EineKleine3DRenderer) in SwiftUI.

# Usage

````swift
import EineKleine3DRendererView

struct TeaPot: View {
	
	@State private var mesh = {
		var mesh = Mesh()
		try! mesh.loadMesh(fromObjectFile: "myMesh.obj")
		return mesh
	}()

	private let renderer = Renderer(meshes: [self.mesh])
	
	var body: some View {
		EineKleine3DRendererView(
			renderer: self.renderer,
			camera: .pointsAtTarget(
				position: Vertex3d(x: 2.5, y: 0, z: 0),
				target: .zero),
			faceRenderOptions: .shaded(color: Color.primary),
			edgeRenderOptions: .visible(color: Color.seconday))
	}
	
}
````

# License

See license in LICENSE.

