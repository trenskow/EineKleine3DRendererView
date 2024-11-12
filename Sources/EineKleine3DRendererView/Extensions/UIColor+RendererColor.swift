//
//  UIColor+RendererColor.swift
//  EineKleine3DRendererView
//
//  Created by Kristian Trenskow on 12/11/2024.
//

import SwiftUI
import EineKleine3DRenderer

extension UIColor: RendererColor {

	public func rendererColor(
		in environment: EnvironmentValues
	) -> EineKleine3DRenderer.Color {

		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0

		self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

		return EineKleine3DRenderer.Color(
			Float(red),
			Float(green),
			Float(blue),
			Float(alpha))

	}

}
