//
//  BackgroundImageView.swift
//  MyFirstImmersive
//
//  Created by Kody Buss on 1/16/24.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
		Image("Earth Space")
			.resizable()
			.aspectRatio(contentMode: .fit)
			.cornerRadius(60)
    }
}

#Preview {
    BackgroundImageView()
}
