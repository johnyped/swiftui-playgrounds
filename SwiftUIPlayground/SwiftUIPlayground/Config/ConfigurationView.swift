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
                                Text(configuration.appEnvironment.environmentName)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    // App Configuration Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("App")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ConfigRow(title: "App Name", value: configuration.appName)
                            ConfigRow(title: "Logging Enabled", value: String(configuration.logEnabled))
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(10)
                    }
                    
                    // API Configuration Section
                    VStack(alignment: .leading, spacing: 15) {
                        Text("API")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            ConfigRow(title: "Base URL", value: configuration.pmsApiBaseUrl)
                            ConfigRow(title: "Version", value: configuration.pmsApiVersion)
                            ConfigRow(title: "Full Base URL", value: configuration.pmsApiBaseURL)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
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
