//
//  MyFirstImmersiveApp.swift
//  MyFirstImmersive
//
//  Created by Kody Buss on 1/12/24.
//

import SwiftUI

@main
struct MyFirstImmersiveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
