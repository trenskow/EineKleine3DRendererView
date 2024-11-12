//
//  Renderer.swift
//  EineKleine3DRendererView
//
//  Created by Kristian Trenskow on 11/11/2024.
//

import EineKleine3DRenderer
import SwiftUI

public struct Renderer {

	public struct Result {

		public struct Fill {
			public var points: (x: CGPoint, y: CGPoint, z: CGPoint)
			public var color: SwiftUI.Color
		}

		public struct Stroke {
			public var start: CGPoint
			public var end: CGPoint
			public var color: SwiftUI.Color
		}

		public var fills: [Fill]
		public var strokes: [Stroke]

	}

	public enum Camera {
		case pointsAtTarget(position: Vertex3d, target: Vertex3d)
		case pointsInDirection(position: Vertex3d, direction: Vertex3d)
	}

	public enum FaceRenderOptions {
		case solid(EineKleine3DRenderer.Color)
		case shaded(EineKleine3DRenderer.Color)
	}

	public enum EdgeRenderOptions {
		case visible(EineKleine3DRenderer.Color)
		case wireframe(EineKleine3DRenderer.Color)
	}

	private let renderer: EineKleine3DRenderer.Renderer

	public init() {
		self.renderer = EineKleine3DRenderer.Renderer()
	}

	public init(
		meshes: [Mesh]
	) {

		var meshesVector = Meshes()

		meshes.forEach { mesh in
			meshesVector.push_back(mesh)
		}

		self.renderer = EineKleine3DRenderer.Renderer(meshesVector)

	}

	public func render(
		camera: Camera,
		size: CGSize,
		faceRenderOptions: FaceRenderOptions? = nil,
		edgeRenderOptions: EdgeRenderOptions? = nil
	) -> Result {

		var result = RenderResult()

		self.renderer.render(
			&result,
			Float(size.width),
			Float(size.height),
			faceRenderOptions.color,
			edgeRenderOptions.color,
			camera.camera,
			faceRenderOptions.options,
			edgeRenderOptions.options)

		return Result(
			fills: result.fills.map({ fill in
				return Result.Fill(
					points: (
						x: fill.face.p.0.cgPoint,
						y: fill.face.p.1.cgPoint,
						z: fill.face.p.2.cgPoint),
					color: fill.color.swiftColor)
			}),
			strokes: result.strokes.map({ line in
				return Result.Stroke(
					start: line.edge.p.0.cgPoint,
					end: line.edge.p.1.cgPoint,
					color: line.color.swiftColor)
			}))

	}

}

extension Renderer.FaceRenderOptions {

	var color: EineKleine3DRenderer.Color {
		switch self {
		case .solid(let color):
			return color
		case .shaded(let color):
			return color
		}
	}

	var options: EineKleine3DRenderer.Renderer.FaceRenderOptions {
		switch self {
		case .solid:
			return .solid
		case .shaded:
			return .shaded
		}
	}

}

extension Optional where Wrapped == Renderer.FaceRenderOptions {

	var color: EineKleine3DRenderer.Color {
		switch self {
		case .some(let wrapped):
			return wrapped.color
		case .none:
			return Color(0, 0, 0, 0)
		}
	}

	var options: EineKleine3DRenderer.Renderer.FaceRenderOptions {
		switch self {
		case .some(let wrapped):
			return wrapped.options
		case .none:
			return .none
		}
	}

}

extension Renderer.EdgeRenderOptions {

	var color: EineKleine3DRenderer.Color {
		switch self {
		case .visible(let color):
			return color
		case .wireframe(let color):
			return color
		}
	}

	var options: EineKleine3DRenderer.Renderer.EdgeRenderOptions {
		switch self {
		case .visible:
			return .visible
		case .wireframe:
			return .wireframe
		}
	}

}

extension Optional where Wrapped == Renderer.EdgeRenderOptions {

	var color: EineKleine3DRenderer.Color {
		switch self {
		case .some(let wrapped):
			return wrapped.color
		case .none:
			return Color(0, 0, 0, 0)
		}
	}

	var options: EineKleine3DRenderer.Renderer.EdgeRenderOptions {
		switch self {
		case .some(let wrapped):
			return wrapped.options
		case .none:
			return .none
		}
	}

}

extension Renderer.Camera {

	var camera: EineKleine3DRenderer.Camera {
		switch self {
		case .pointsAtTarget(let position, let target):
			return EineKleine3DRenderer.Camera.lookAtTarget(
				EineKleine3DRenderer.Vertex3d(x: position.x, y: position.y, z: position.z, w: 1),
				EineKleine3DRenderer.Vertex3d(x: target.x, y: target.y, z: target.z, w: 1))
		case .pointsInDirection(let position, let direction):
			return EineKleine3DRenderer.Camera.lookInDirection(
				EineKleine3DRenderer.Vertex3d(x: position.x, y: position.y, z: position.z, w: 1),
				EineKleine3DRenderer.Vertex3d(x: direction.x, y: direction.y, z: direction.z, w: 1))
		}
	}

}

extension Vertex2d {
	var cgPoint: CGPoint {
		return CGPoint(
			x: CGFloat(self.x),
			y: CGFloat(self.y))
	}
}

extension EineKleine3DRenderer.Color {
	var swiftColor: SwiftUI.Color {
		return SwiftUI.Color(
			red: Double(self.red),
			green: Double(self.green),
			blue: Double(self.blue),
			opacity: Double(self.alpha))
	}
}
