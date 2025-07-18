//
//  LoginView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//
import SwiftUI
import AuthenticationServices

// MARK: - Models
struct LoginRequest: Codable {
    let username: String
    let password: String
}

struct AppleLoginRequest: Codable {
    let code: String
    let first_name: String
    let last_name: String
    let email: String
}

struct LoginResponse: Codable {
    let access_token: String
    let refresh_token: String
}

enum LoginError: Error {
    case invalidCredentials
    case networkError(String)
    case appleSignInFailed
    case tokenValidationFailed
    case unknownError
    
    var message: String {
        switch self {
        case .invalidCredentials:
            return "Invalid email or password"
        case .networkError(let message):
            return "Network error: \(message)"
        case .appleSignInFailed:
            return "Apple Sign In failed"
        case .tokenValidationFailed:
            return "Token validation failed"
        case .unknownError:
            return "An unknown error occurred"
        }
    }
}

// MARK: - Login View (copied for now)
struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @State private var showHomeView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Header
                VStack(spacing: 10) {
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Sign in to continue")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 50)
                
                Spacer()
                
                // View Section 1: Email/Password Login
                VStack(spacing: 20) {
                    Text("Login with Email")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15) {
                        TextField("Email", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Button(action: {
                        Task {
                            await viewModel.loginWithEmail()
                        }
                    }) {
                        HStack {
                            if viewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            }
                            Text(viewModel.isLoading ? "Signing In..." : "Sign In")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .disabled(viewModel.isLoading)
                }
                .padding(.horizontal, 30)
                
                // Divider
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.3))
                    
                    Text("OR")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 10)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.3))
                }
                .padding(.horizontal, 30)
                
                // View Section 2: Apple ID Login
                VStack(spacing: 20) {
                    Text("Login with Apple ID")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    SignInWithAppleButton(
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]
                        },
                        onCompletion: { result in
                            switch result {
                            case .success(let authResults):
                                if let appleIDCredential = authResults as? ASAuthorizationAppleIDCredential {
                                    Task {
                                        await viewModel.handleAppleSignInResult(credential: appleIDCredential)
                                    }
                                }
                            case .failure(let error):
                                print("Apple Sign In failed: \(error.localizedDescription)")
                                viewModel.errorMessage = "Apple Sign In failed. Please try again."
                                viewModel.showError = true
                            }
                        }
                    )
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 50)
                    .disabled(viewModel.isLoading)
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .sheet(isPresented: $viewModel.showError) {
                ErrorSheetView(errorMessage: viewModel.errorMessage) {
                    viewModel.showError = false
                }
            }
            .onChange(of: viewModel.isLoggedIn) { isLoggedIn in
                if isLoggedIn {
                    showHomeView = true
                }
            }
            .navigationDestination(isPresented: $showHomeView) {
                HomeView()
            }
        }
    }
}
