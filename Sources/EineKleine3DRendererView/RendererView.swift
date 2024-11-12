//
//  RendererView.swift
//  RendererView
//
//  Created by Kristian Trenskow on 09/11/2024.
//

import SwiftUI
import EineKleine3DRenderer

public struct RendererView: View {

	@Environment(\.self) var environment

	private let renderer: Renderer
	private let camera: Renderer.Camera
	private let faceRenderOptions: FaceRenderOptions?
	private let edgeRenderOptions: EdgeRenderOptions?

	public init(
		renderer: Renderer,
		camera: Renderer.Camera,
		faceRenderOptions: FaceRenderOptions? = .shaded(color: SwiftUI.Color.secondary),
		edgeRenderOptions: EdgeRenderOptions? = nil
	) {
		self.renderer = renderer
		self.camera = camera
		self.faceRenderOptions = faceRenderOptions
		self.edgeRenderOptions = edgeRenderOptions
	}

	public var body: some View {
		Canvas { context, size in

			let result = self.renderer.render(
				camera: self.camera,
				size: size,
				faceRenderOptions: self.faceRenderOptions?.rendererOptions(in: self.environment),
				edgeRenderOptions: self.edgeRenderOptions?.rendererOptions(in: self.environment))

			result.fills
				.forEach { fill in

					var fillPath = Path()

					fillPath.move(to: fill.points.x)
					fillPath.addLine(to: fill.points.y)
					fillPath.addLine(to: fill.points.z)
					fillPath.addLine(to: fill.points.x)

					context.fill(
						fillPath,
						with: .color(fill.color))

				}

			result.strokes
				.forEach { stroke in

					var strokePath = Path()

					strokePath.move(to: stroke.start)
					strokePath.addLine(to: stroke.end)

					context.stroke(
						strokePath,
						with: .color(stroke.color),
						lineWidth: 2)

				}

		}
	}
}

extension FaceRenderOptions {
	fileprivate func rendererOptions(
		in environment: EnvironmentValues
	) -> Renderer.FaceRenderOptions {
		switch self {
		case .solid(let color):
			return .solid(color.rendererColor(in: environment))
		case .shaded(let color):
			return .shaded(color.rendererColor(in: environment))
		}
	}
}

extension EdgeRenderOptions {
	fileprivate func rendererOptions(
		in environment: EnvironmentValues
	) -> Renderer.EdgeRenderOptions {
		switch self {
		case .visible(let color):
			return .visible(color.rendererColor(in: environment))
		case .wireframe(let color):
			return .wireframe(color.rendererColor(in: environment))
		}
	}
}
