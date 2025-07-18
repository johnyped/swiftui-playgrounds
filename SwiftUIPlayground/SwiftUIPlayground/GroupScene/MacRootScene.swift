//
//  MacRootScene.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//
import SwiftUI

struct MacRootScene: Scene {
    var body: some Scene {
        WindowGroup {
            Text("Mac")
        }
        
        #if os(macOS)
        Settings {
            SettingsView()
        }
        #endif
    }
}
