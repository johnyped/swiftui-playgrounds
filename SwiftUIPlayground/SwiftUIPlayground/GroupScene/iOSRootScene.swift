//
//  iOSRootScene.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//

import SwiftUI
import Observation

struct iOSRootScene: Scene {
    
//    @StateObject
//    var tokenStorage: TokenStorage = TokenStorage.shared
    
    @Bindable
    var appState: AppState = .init(tokenStorage: TokenStorage.shared)
    
    var body: some Scene {
        WindowGroup {
            Group {
                if appState.isAuthenticated {
                    HomeView()
                } else {
                    LoginView()
                }
            }
            //.environmentObject(tokenStorage)
            .environment(appState)
        }
    }
}
