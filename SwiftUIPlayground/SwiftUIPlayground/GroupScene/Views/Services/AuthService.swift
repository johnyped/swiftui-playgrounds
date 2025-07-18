//
//  AuthService.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//
import SwiftUI

@Observable
class AuthService {
    static let shared = AuthService()
    
    private let tokenManager = TokenManager.shared
    private var configuration: EnvironmentConfig
    
    init(configuration: EnvironmentConfig = EnvironmentConfig.development) {
        self.configuration = configuration
    }
    
    func updateConfiguration(_ config: EnvironmentConfig) {
        self.configuration = config
    }
    
    private init() {
        self.configuration = EnvironmentConfig.development
    }
    
    func loginWithEmail(username: String, password: String) async throws -> LoginResponse {
        let url = URL(string: configuration.authLoginURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginRequest = LoginRequest(username: username, password: password)
        request.httpBody = try JSONEncoder().encode(loginRequest)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw LoginError.networkError("Invalid response")
        }
        
        if httpResponse.statusCode == 200 {
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            tokenManager.saveTokens(accessToken: loginResponse.access_token, refreshToken: loginResponse.refresh_token)
            return loginResponse
        } else {
            throw LoginError.invalidCredentials
        }
    }
    
    func loginWithApple(code: String, firstName: String, lastName: String, email: String) async throws -> LoginResponse {
        let url = URL(string: configuration.authAppleLoginURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let appleLoginRequest = AppleLoginRequest(
            code: code,
            first_name: firstName,
            last_name: lastName,
            email: email
        )
        request.httpBody = try JSONEncoder().encode(appleLoginRequest)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw LoginError.networkError("Invalid response")
        }
        
        if httpResponse.statusCode == 200 {
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            tokenManager.saveTokens(accessToken: loginResponse.access_token, refreshToken: loginResponse.refresh_token)
            return loginResponse
        } else {
            throw LoginError.appleSignInFailed
        }
    }
    
    func validateToken() async throws -> Bool {
        guard let token = tokenManager.getAccessToken() else {
            throw LoginError.tokenValidationFailed
        }
        
        let url = URL(string: configuration.hotelsURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw LoginError.networkError("Invalid response")
        }
        
        return httpResponse.statusCode == 200
    }
    
    func logout() {
        tokenManager.clearTokens()
    }
}
