//
//  TokenManager.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//
import SwiftUI
import AuthenticationServices

@Observable
class TokenManager {
    static let shared = TokenManager()
    
    private let accessTokenKey = "access_token"
    private let refreshTokenKey = "refresh_token"
    
    var isAuthenticated: Bool = false
    
    private init() {
        isAuthenticated = hasValidToken()
    }
    
    func saveTokens(accessToken: String, refreshToken: String) {
        UserDefaults.standard.set(accessToken, forKey: accessTokenKey)
        UserDefaults.standard.set(refreshToken, forKey: refreshTokenKey)
        isAuthenticated = true
    }
    
    func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: accessTokenKey)
    }
    
    func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: refreshTokenKey)
    }
    
    func hasValidToken() -> Bool {
        return getAccessToken() != nil
    }
    
    func clearTokens() {
        UserDefaults.standard.removeObject(forKey: accessTokenKey)
        UserDefaults.standard.removeObject(forKey: refreshTokenKey)
        isAuthenticated = false
    }
    
    func getAuthorizationHeader() -> [String: String] {
        guard let token = getAccessToken() else {
            return [:]
        }
        return ["Authorization": "Bearer \(token)"]
    }
}
