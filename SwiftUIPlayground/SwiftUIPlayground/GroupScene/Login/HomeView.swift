//
//  HomeView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 6/8/2568 BE.
//

import SwiftUI

struct HomeView: View {
    //@EnvironmentObject var tokenStorage: TokenStorage
    //@Environment(AppState.self) private var appState
    @State var vm: HomeViewVM
    
    var body: some View {
        Text("HomeView")
        
        VStack {
            HStack {
                Text("isAuthenticated: ")
                //Text("\(appState.isAuthenticated ? "true" : "false")")
                Text("\(vm.isAuthenticated ? "true" : "false")")
            }
            HStack {
                Text("Access Token: ")
                //Text("\(appState.tokenStorage.accessToken ?? "N/A")")
                Text("\(vm.accessToken ?? "N/A")")
            }
            HStack {
                Text("Refresh Token: ")
                //Text("\(appState.tokenStorage.refreshToken ?? "N/A")")
                Text("\(vm.refreshToken ?? "N/A")")
            }
        }.multilineTextAlignment(.leading)
        Spacer().frame(height: 50)
        Button("Logout") {
//            tokenStorage.clearTokens()
            //appState.tokenStorage.clearTokens()
            vm.clearToken()
            print(">>> Logout success")
            //appState.debug()
            vm.debug()
        }
        
        Button("Read TokenStorage") {
            let ts = TokenStorage.shared
            print(">>>>>>>>>>>>>>>>>>>>>>>")
            print(">>> Read TokenStorage")
            print("tokenStorage.accessToken: \(ts.accessToken ?? "N/A")")
            print("tokenStorage.refreshToken: \(ts.refreshToken ?? "N/A")")
        }
    }
}
