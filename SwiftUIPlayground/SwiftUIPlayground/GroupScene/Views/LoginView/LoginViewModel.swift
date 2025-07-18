//
//  LoginViewModel.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//

import SwiftUI
import AuthenticationServices

// MARK: - ViewModel and Services
@MainActor
@Observable class LoginViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var showError = false
    var errorMessage = ""
    var isLoggedIn = false
    
    private let authService = AuthService.shared
    private let tokenManager = TokenManager.shared
    
    init() {
        isLoggedIn = tokenManager.isAuthenticated
    }
    
    func loginWithEmail() async {
        guard !email.isEmpty && !password.isEmpty else {
            showError(message: "Please enter email and password")
            return
        }
        
        isLoading = true
        
        do {
            let _ = try await authService.loginWithEmail(username: email, password: password)
            isLoggedIn = true
        } catch {
            if let loginError = error as? LoginError {
                showError(message: loginError.message)
            } else {
                showError(message: "Login failed. Please try again.")
            }
        }
        
        isLoading = false
    }
    
    func handleAppleSignInResult(credential: ASAuthorizationAppleIDCredential) async {
        isLoading = true
        
        do {
            let code = String(data: credential.authorizationCode!, encoding: .utf8) ?? ""
            let firstName = credential.fullName?.givenName ?? ""
            let lastName = credential.fullName?.familyName ?? ""
            let email = credential.email ?? ""
            
            let _ = try await authService.loginWithApple(
                code: code,
                firstName: firstName,
                lastName: lastName,
                email: email
            )
            
            isLoggedIn = true
        } catch {
            if let loginError = error as? LoginError {
                showError(message: loginError.message)
            } else {
                showError(message: "Apple Sign In failed. Please try again.")
            }
        }
        
        isLoading = false
    }
    
    private func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    func logout() {
        authService.logout()
        isLoggedIn = false
        email = ""
        password = ""
    }
}
