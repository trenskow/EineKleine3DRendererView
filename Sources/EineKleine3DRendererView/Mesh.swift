//
//  Mesh.swift
//  EineKleine3DRendererView
//
//  Created by Kristian Trenskow on 12/11/2024.
//

@_exported import EineKleine3DRenderer

extension Mesh {

	public enum Error: Swift.Error {
		case loadError
	}

	public mutating func loadMesh(
		fromObjectFile file: String
	) throws {
		guard self.loadFromObjectFile(std.string(file)) else {
			throw Error.loadError
		}
	}
}
