//
//  Vector3d.swift
//  EineKleine3DRendererView
//
//  Created by Kristian Trenskow on 11/11/2024.
//

public struct Vertex3d: Sendable {

	public let x: Float
	public let y: Float
	public let z: Float

	public init(
		x: Float = 0,
		y: Float = 0,
		z: Float = 0
	) {
		self.x = x
		self.y = y
		self.z = z
	}

}

extension Vertex3d {
	public static let zero = Vertex3d()
}
