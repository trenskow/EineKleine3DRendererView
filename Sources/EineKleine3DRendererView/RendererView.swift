//
//  RendererView.swift
//  RendererView
//
//  Created by Kristian Trenskow on 09/11/2024.
//

import SwiftUI
import EineKleine3DRenderer

public struct RendererView<FaceColor: RendererColor, EdgeColor: RendererColor>: View {

	@Environment(\.self) var environment

	private let renderer: Renderer
	private let camera: Renderer.Camera
	private let faceColor: RendererColor
	private let edgeColor: RendererColor

	public init(
		renderer: Renderer,
		camera: Renderer.Camera,
		faceColor: FaceColor = SwiftUI.Color.secondary,
		edgeColor: EdgeColor = SwiftUI.Color.clear
	) {
		self.renderer = renderer
		self.camera = camera
		self.faceColor = faceColor
		self.edgeColor = edgeColor
	}

	public var body: some View {
		Canvas { context, size in

			let result = self.renderer.render(
				camera: self.camera,
				size: size,
				faceColor: self.faceColor.rendererColor(in: self.environment),
				edgeColor: self.edgeColor.rendererColor(in: self.environment))

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

			result.lines
				.forEach { line in

					var linePath = Path()

					linePath.move(to: line.start)
					linePath.addLine(to: line.end)

					context.stroke(
						linePath,
						with: .color(line.color),
						lineWidth: 2)

				}

		}
	}
}
