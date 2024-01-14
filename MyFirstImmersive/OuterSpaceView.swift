//
//  OuterSpaceView.swift
//  MyFirstImmersive
//
//  Created by Kody Buss on 1/12/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

// Component for the toggle switch with glass effect
struct ImmersiveToggle: View {
	@Binding var isOn: Bool

	var body: some View {
		Toggle("Immersive View", isOn: $isOn)
			.font(.callout)
			.frame(width: 175, alignment: .center)
			.padding()
			.glassBackgroundEffect()
	}
}

// Main View
struct OuterSpaceView: View {
	@State private var isImmersiveSpaceShown = false

	@Environment(\.openImmersiveSpace) var openImmersiveSpace
	@Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
	
	var body: some View {
		ZStack(alignment: .top) {
			BackgroundImageView()
			HelloWorldView(isImmersiveSpaceShown: $isImmersiveSpaceShown)
		}
		.glassBackgroundEffect()
		.onChange(of: isImmersiveSpaceShown) { _, newValue in
			handleImmersiveSpaceChange(isShown: newValue)
		}
	}

	private func BackgroundImageView() -> some View {
		Image("Earth Space")
			.resizable()
			.aspectRatio(contentMode: .fit)
	}

	private func HelloWorldView(isImmersiveSpaceShown: Binding<Bool>) -> some View {
		Text("Hello World")
			.padding(50)
			.kerning(20)
			.font(.extraLargeTitle)
			.fontDesign(.monospaced)
			.fontWeight(.ultraLight)
			.ornament(attachmentAnchor: .scene(.bottom)) {
				ImmersiveToggle(isOn: isImmersiveSpaceShown)
			}
	}

	// Handle immersive space state change
	private func handleImmersiveSpaceChange(isShown: Bool) {
		Task {
			if isShown {
				switch await openImmersiveSpace(id: "ImmersiveSpace") {
				case .opened:
					isImmersiveSpaceShown = true
				case .error, .userCancelled:
					fallthrough
				@unknown default:
					isImmersiveSpaceShown = false
				}
			} else {
				await dismissImmersiveSpace()
				isImmersiveSpaceShown = false
			}
		}
	}
}

#Preview{
	OuterSpaceView()
}
