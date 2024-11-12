//
//  CGColor+RendererColor.swift
//  EineKleine3DRendererView
//
//  Created by Kristian Trenskow on 12/11/2024.
//

import SwiftUI
import EineKleine3DRenderer

extension CGColor: RendererColor {
	
	public func rendererColor(
		in environment: EnvironmentValues
	) -> EineKleine3DRenderer.Color {

		let components = self.components!

		return EineKleine3DRenderer.Color(
			Float(components[0]),
			Float(components[1]),
			Float(components[2]),
			Float(components[3]))

	}

}
