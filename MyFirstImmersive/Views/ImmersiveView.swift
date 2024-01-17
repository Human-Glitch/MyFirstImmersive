//
//  ImmersiveView.swift
//  MyFirstImmersive
//
//  Created by Kody Buss on 1/12/24.
//

import SwiftUI
import RealityKit
import WorldAssets

struct ImmersiveView: View {
	var body: some View {
		RealityView { content in
			
			// Create a material with a star field on it.
			guard let resource =
				try? await TextureResource(named: "Starfield")
				else {
					// If the asset isn't available, something is wrong with the app.
					fatalError("Unable to load starfield texture.")
				}
			
			var material = UnlitMaterial()
			material.color = .init(texture: .init(resource))
			
			// Attach the material to a large sphere.
			let skybox = Entity()
			skybox.components.set(ModelComponent(
				mesh: .generateSphere(radius: 1000),
				materials: [material]
			))
			
			// Ensure the texture image points inward at the viewer.
			skybox.scale *= .init(x: -1, y: 1, z: 1)
			
			content.add(skybox)
			
			if let earth = try? await Entity(named: "Earth", in: worldAssetsBundle) {
				earth.scale = .init(x: 250, y: 250, z:250)
				earth.position = .init(x: -25, y: -30, z: -225)
				earth.transform.rotation = simd_quatf(angle: Float(23.5 * 3.1416 / 180), axis: [0, 0, 1])
				content.add(earth)
			}
			
			if let sun = try? await Entity(named: "Sun", in: worldAssetsBundle) {
				sun.scale = .init(x: 150, y: 150, z: 150)
				sun.position = .init(x: -700, y: 500, z: -500)
				sun.transform.rotation = simd_quatf(angle: Float(75 * 3.1416 / 180), axis: [1, 1, 0])
				sun.setSunlight(intensity: 1000)
				
				content.add(sun)
			}
			
			if let moon = try? await Entity(named: "Moon", in: worldAssetsBundle) {
				moon.scale = .init(x: 50, y: 50, z: 50)
				moon.position = .init(x: 25, y: 10, z: -50)
				content.add(moon)
			}
		}
	}
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
