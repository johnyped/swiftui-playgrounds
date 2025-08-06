//
//  iOSRootScene.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//

import SwiftUI

struct iOSRootScene: Scene {
    
    @StateObject
    var tokenStorage: TokenStorage = TokenStorage.shared
    
    var body: some Scene {
        WindowGroup {
            Group {
                if tokenStorage.isAuthenticated {
                    HomeView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(tokenStorage)
        }
    }
}
