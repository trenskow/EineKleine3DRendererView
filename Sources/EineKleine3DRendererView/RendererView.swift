//
//  RendererView.swift
//  RendererView
//
//  Created by Kristian Trenskow on 09/11/2024.
//

import SwiftUI
import EineKleine3DRenderer

struct RendererView: View {

	private let renderer: Renderer
	private let camera: Renderer.Camera

	init(
		renderer: Renderer,
		camera: Renderer.Camera
	) throws {
		self.renderer = renderer
		self.camera = camera
	}

	var body: some View {
		Canvas { context, size in

			self.renderer.render(
				camera: self.camera,
				size: size)
			.forEach { line in

				var path = Path()

				path.move(to: line.start)
				path.addLine(to: line.end)

				context.stroke(path, with: .color(.primary), lineWidth: 2)

			}

		}
	}
}

extension [TimeInterval] {
	var fps: Double {
		return Double(self.count)
	}
}

extension Vertex2d {
	var cgPoint: CGPoint {
		return CGPoint(
			x: CGFloat(self.x),
			y: CGFloat(self.y))
	}
}

extension Vertex3d {
	var cgPoint: CGPoint {
		return CGPoint(
			x: CGFloat(self.x),
			y: CGFloat(self.y))
	}
}
