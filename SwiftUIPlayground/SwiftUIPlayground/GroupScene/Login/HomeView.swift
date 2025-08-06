//
//  HomeView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 6/8/2568 BE.
//

import SwiftUI

struct HomeView: View {
    //@EnvironmentObject var tokenStorage: TokenStorage
    @Environment(AppState.self) private var appState
    
    var body: some View {
        Text("HomeView")
        
        VStack {
            HStack {
                Text("isAuthenticated: ")
                Text("\(appState.isAuthenticated ? "true" : "false")")
            }
            HStack {
                Text("Access Token: ")
                Text("\(appState.tokenStorage.accessToken ?? "N/A")")
            }
            HStack {
                Text("Refresh Token: ")
                Text("\(appState.tokenStorage.refreshToken ?? "N/A")")
            }
        }.multilineTextAlignment(.leading)
        
        Button("Logout") {
//            tokenStorage.clearTokens()
            appState.tokenStorage.clearTokens()
            print(">>> Logout success")
            appState.debug()
        }
    }
}
