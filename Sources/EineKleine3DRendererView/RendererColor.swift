//
//  RendererColor.swift
//  EineKleine3DRendererView
//
//  Created by Kristian Trenskow on 12/11/2024.
//

import SwiftUI
import EineKleine3DRenderer

public protocol RendererColor {
	func rendererColor(
		in environment: EnvironmentValues
	) -> EineKleine3DRenderer.Color
}
