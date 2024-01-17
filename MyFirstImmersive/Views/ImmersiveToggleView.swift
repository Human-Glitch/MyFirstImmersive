//
//  ImmersiveToggle.swift
//  MyFirstImmersive
//
//  Created by Kody Buss on 1/16/24.
//

import SwiftUI

// Component for the toggle switch with glass effect
struct ImmersiveToggleView: View {
	@Binding var isOn: Bool

	var body: some View {
		Toggle("Immersive View", isOn: $isOn)
			.font(.callout)
			.frame(width: 200, alignment: .center)
			.padding()
			.glassBackgroundEffect()
	}
}

#Preview {
	ImmersiveToggleView(isOn: .constant(false))
}
