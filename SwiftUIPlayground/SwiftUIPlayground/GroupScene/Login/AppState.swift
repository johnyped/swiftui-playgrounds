//
//  AppState.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 6/8/2568 BE.
//
import Foundation
import Observation

@Observable
class AppState {
    var isAuthenticated: Bool
    
    var tokenStorage: TokenStorage {
        didSet {
            isAuthenticated = tokenStorage.isAuthenticated
        }
    }
    
    init(tokenStorage: TokenStorage = .shared) {
        self.tokenStorage = tokenStorage
        self.isAuthenticated = tokenStorage.isAuthenticated
    }
    
    func debug() {
        print("#########")
        print("isAuthenticated: \(isAuthenticated ? "true" : "false")")
        print("Access Token: \(tokenStorage.accessToken ?? "N/A")")
        print("Refresh Token: \(tokenStorage.refreshToken ?? "N/A")")        
    }

}
