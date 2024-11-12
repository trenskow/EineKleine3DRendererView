// swift-tools-version:6.0

//
//  Package.swift
//  EineKleine3DRendererView
//
//  Created by Kristian Trenskow on 10/11/2024.
//

import PackageDescription

let package = Package(
	name: "EineKleine3DRendererView",
	platforms: [.iOS(.v17)],
	products: [
		.library(
			name: "EineKleine3DRendererView", 
			targets: ["EineKleine3DRendererView"]),
	],
	dependencies: [
		.package(url: "https://github.com/trenskow/EineKleine3DRenderer.git", branch: "main"),
	],
	targets: [
		.target(
			name: "EineKleine3DRendererView",
			dependencies: [
				.product(name: "EineKleine3DRenderer", package: "EineKleine3DRenderer")
			],
			swiftSettings: [.interoperabilityMode(.Cxx)])
	]
)
