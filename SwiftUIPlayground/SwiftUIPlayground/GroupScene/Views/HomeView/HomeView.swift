//
//  HomeView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//
import SwiftUI

// MARK: - Home View
struct HomeView: View {
    @State private var tokenManager = TokenManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "house.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("Welcome to Home")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("You have successfully logged in!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                Button("Logout") {
                    tokenManager.clearTokens()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal, 30)
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
