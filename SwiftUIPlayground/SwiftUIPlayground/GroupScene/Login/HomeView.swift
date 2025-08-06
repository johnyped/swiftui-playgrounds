//
//  HomeView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 6/8/2568 BE.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var tokenStorage: TokenStorage
    
    var body: some View {
        Text("HomeView")
        Button("Logout") {
            tokenStorage.clearTokens()
            print(">>> Logout success")
        }
    }
}
