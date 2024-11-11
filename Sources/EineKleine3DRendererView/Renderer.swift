//
//  Renderer.swift
//  EineKleine3DRendererView
//
//  Created by Kristian Trenskow on 11/11/2024.
//

import EineKleine3DRenderer
import QuartzCore

public class Renderer {

	public enum Camera {
		case pointsAtTarget(position: Vertex3d, target: Vertex3d)
		case pointsInDirection(position: Vertex3d, direction: Vertex3d)
	}

	public enum RendererError: Error {
		case modelLoadError
	}

	private var renderer = EineKleine3DRenderer.Renderer()

	public init() {}

	public func load(objectFile: String) throws {
		guard renderer.loadModel(std.string(objectFile)) else {
			throw RendererError.modelLoadError
		}
	}

	public func render(
		camera: Camera,
		size: CGSize
	) -> [(start: CGPoint, end: CGPoint)] {

		var edges = Edges2d()

		self.renderer.render(
			&edges,
			Float(size.width),
			Float(size.height),
			camera.camera)

		return edges.map { (start: $0.p.0.cgPoint, end: $0.p.1.cgPoint) }

	}

}

extension Renderer {
	public convenience init(
		objectFile: String
	) throws {
		self.init()
		try self.load(objectFile: objectFile)
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
