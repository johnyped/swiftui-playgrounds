//
//  ConfigurationView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//

import SwiftUI

struct ConfigurationView: View {
    @Environment(\.configuration) var configuration
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Environment Info
                    VStack(spacing: 15) {                       
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Environment:")
                                    .fontWeight(.semibold)
                                Spacer()
                                Text(configuration.environmentName)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    // API Configuration Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("API")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ConfigRow(title: "Base URL", value: configuration.api.baseUrl)
                            ConfigRow(title: "Version", value: configuration.api.version)
                            
                            Divider()
                            
                            Text("Endpoints")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 5)
                            
                            ConfigRow(title: "Auth Login", value: configuration.api.endpoints.authLogin)
                            ConfigRow(title: "Apple Login", value: configuration.api.endpoints.authAppleLogin)
                            ConfigRow(title: "Hotels", value: configuration.api.endpoints.hotels)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    // App Configuration Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("App")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ConfigRow(title: "App Name", value: configuration.app.name)
                            ConfigRow(title: "Debug Mode", value: String(configuration.app.debugMode))
                            ConfigRow(title: "Timeout Interval", value: "\(configuration.app.timeoutInterval)s")
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    // Features Configuration Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Features")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ConfigRow(title: "Logging", value: String(configuration.features.logging))
                            ConfigRow(title: "Analytics", value: String(configuration.features.analytics))
                            ConfigRow(title: "Crash Reporting", value: String(configuration.features.crashReporting))
                        }
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    // Full URLs Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Full API URLs")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ConfigRow(title: "Full Base URL", value: configuration.fullAPIBaseURL)
                            ConfigRow(title: "Auth Login URL", value: configuration.authLoginURL)
                            ConfigRow(title: "Apple Login URL", value: configuration.authAppleLoginURL)
                            ConfigRow(title: "Hotels URL", value: configuration.hotelsURL)
                        }
                        .padding()
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("Configuration")
        }
    }
}

// Helper view for consistent row styling
struct ConfigRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
                .font(.caption)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    ConfigurationView()
        .environment(\.configuration, EnvironmentConfig())
}
