//
//  OuterSpaceView.swift
//  MyFirstImmersive
//
//  Created by Kody Buss on 1/12/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

// Main View
struct OuterSpaceView: View {
	@State private var isImmersiveSpaceShown = false
	
	@Environment(\.openImmersiveSpace) var openImmersiveSpace
	@Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
	
	var body: some View {
		ZStack{
			BackgroundImageView()
				
			VStack(alignment: .center, content: {
				HelloWorldView()
				Spacer()
				ImmersiveToggleView(isOn: $isImmersiveSpaceShown)
			})
			.padding()
		}
		.frame(width: 950, height: 550, alignment: .center)
		.onChange(of: isImmersiveSpaceShown) { _, newValue in
			handleImmersiveSpaceChange(isShown: newValue)
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
