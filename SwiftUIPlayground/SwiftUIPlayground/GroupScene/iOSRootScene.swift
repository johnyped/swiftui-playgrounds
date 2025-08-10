//
//  iOSRootScene.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//

import SwiftUI
import Observation

struct iOSRootScene: Scene {
    
    @State private var tokenStorage: TokenStorage = TokenStorage.shared
    
    var body: some Scene {
        WindowGroup {
            Group {
                if tokenStorage.isAuthenticated {
                    HomeView(vm: HomeViewVM(ts: tokenStorage))
                } else {
                    LoginView(vm: LoginViewVM(ts: tokenStorage))
                }
            }
            .environment(tokenStorage)
        }
    }
}
