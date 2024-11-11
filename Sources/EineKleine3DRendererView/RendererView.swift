//
//  RendererView.swift
//  RendererView
//
//  Created by Kristian Trenskow on 09/11/2024.
//

import SwiftUI
import EineKleine3DRenderer

public struct RendererView: View {

	private let renderer: Renderer
	private let camera: Renderer.Camera

	public init(
		renderer: Renderer,
		camera: Renderer.Camera
	) {
		self.renderer = renderer
		self.camera = camera
	}

	public var body: some View {
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
