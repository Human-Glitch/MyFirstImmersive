//
//  OuterSpaceView.swift
//  MyFirstImmersive
//
//  Created by Kody Buss on 1/12/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct OuterSpaceView: View {
	@State private var showImmersiveSpace = false
	@State private var immersiveSpaceIsShown = false

	@Environment(\.openImmersiveSpace) var openImmersiveSpace
	@Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
	
    var body: some View {
		
		ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
			Image("Earth Space")
				.resizable()
				.scaledToFill()
				.background()
				.presentationCornerRadius(25)
			
			Text("Hello World")
				.padding(50)
				.kerning(25)
				.font(.extraLargeTitle)
				.fontDesign(.monospaced)
				.fontWeight(.ultraLight)
				.ornament(attachmentAnchor: .scene(.bottom)) {
					VStack{
						Toggle("Immersive View", isOn: $showImmersiveSpace)
							.font(.callout)
					}
					.frame(width: 175, alignment: .bottom)
					.padding()
					.glassBackgroundEffect()
				}
			
			
		}).onChange(of: showImmersiveSpace) { _, newValue in
			Task {
				if newValue {
					switch await openImmersiveSpace(id: "ImmersiveSpace") {
					case .opened:
						immersiveSpaceIsShown = true
					case .error, .userCancelled:
						fallthrough
					@unknown default:
						immersiveSpaceIsShown = false
						showImmersiveSpace = false
					}
				} else if immersiveSpaceIsShown {
					await dismissImmersiveSpace()
					immersiveSpaceIsShown = false
				}
			}
		}
    }
}

#Preview (windowStyle: .volumetric){
    OuterSpaceView()
}
