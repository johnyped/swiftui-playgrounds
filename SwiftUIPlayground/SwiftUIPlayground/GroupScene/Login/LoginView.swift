//
//  LoginView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 6/8/2568 BE.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var tokenStorage: TokenStorage
    
    var body: some View {
        Text("LoginView")
        Button("Login") {
            // login
            
            print(">>> Login success")
            tokenStorage.updateTokens(access: "accessToken",
                                      refresh: "refreshToken")
        }
    }
}
