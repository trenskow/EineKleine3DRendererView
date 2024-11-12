//
//  Color+RendererColor.swift
//  EineKleine3DRendererView
//
//  Created by Kristian Trenskow on 12/11/2024.
//

import SwiftUI
import EineKleine3DRenderer

extension SwiftUI.Color: RendererColor {

	public func rendererColor(
		in environment: EnvironmentValues
	) -> EineKleine3DRenderer.Color {

		let components = self.resolve(in: environment)

		return EineKleine3DRenderer.Color(
			Float(components.linearRed),
			Float(components.linearGreen),
			Float(components.linearBlue),
			Float(components.opacity))

	}

}
