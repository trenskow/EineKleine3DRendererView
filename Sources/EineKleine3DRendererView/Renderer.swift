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

		public struct Line {
			public var start: CGPoint
			public var end: CGPoint
			public var color: SwiftUI.Color
		}

		public var fills: [Fill]
		public var lines: [Line]

	}

	public enum Camera {
		case pointsAtTarget(position: Vertex3d, target: Vertex3d)
		case pointsInDirection(position: Vertex3d, direction: Vertex3d)
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
		faceColor: EineKleine3DRenderer.Color,
		edgeColor: EineKleine3DRenderer.Color? = nil
	) -> Result {

		var result = RenderResult()

		self.renderer.render(
			&result,
			Float(size.width),
			Float(size.height),
			faceColor,
			edgeColor ?? Color(0, 0, 0, 0),
			camera.camera)

		return Result(
			fills: result.fills.map({ fill in
				return Result.Fill(
					points: (
						x: fill.face.p.0.cgPoint,
						y: fill.face.p.1.cgPoint,
						z: fill.face.p.2.cgPoint),
					color: fill.color.swiftColor)
			}),
			lines: result.lines.map({ line in
				return Result.Line(
					start: line.edge.p.0.cgPoint,
					end: line.edge.p.1.cgPoint,
					color: line.color.swiftColor)
			}))

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
