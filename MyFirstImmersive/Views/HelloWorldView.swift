//
//  HelloWorldView.swift
//  MyFirstImmersive
//
//  Created by Kody Buss on 1/16/24.
//

import SwiftUI

struct HelloWorldView: View {
    var body: some View {
		Text("Hello World")
			.padding()
			.kerning(20)
			.font(.extraLargeTitle)
			.fontDesign(.monospaced)
			.fontWeight(.ultraLight)
    }
}

#Preview {
    HelloWorldView()
}
