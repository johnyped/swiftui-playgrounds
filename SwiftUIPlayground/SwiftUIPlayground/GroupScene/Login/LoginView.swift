//
//  LoginView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 6/8/2568 BE.
//

import SwiftUI

struct LoginView: View {
    //@EnvironmentObject var tokenStorage: TokenStorage
    @Environment(AppState.self) private var appState

    var body: some View {
        Text("LoginView")
        VStack {
            HStack {
                Text("isAuthenticated: ")
                Spacer()
                Text("\(appState.isAuthenticated ? "true" : "false")")
            }
            HStack {
                Text("Access Token: ")
                Spacer()
                Text("\(appState.tokenStorage.accessToken ?? "N/A")")
            }
            HStack {
                Text("Refresh Token: ")
                Spacer()
                Text("\(appState.tokenStorage.refreshToken ?? "N/A")")
            }
        }.multilineTextAlignment(.leading)
        Button("Login") {
            // login
           
            print(">>> Login success")
            //let tokenStorage = TokenStorage.shared
            
            appState.tokenStorage.updateTokens(
            //tokenStorage.updateTokens(
                access: "accessToken",
                refresh: "refreshToken"
            )
            appState.debug()
        }
    }
}
