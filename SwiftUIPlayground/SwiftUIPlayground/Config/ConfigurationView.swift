//
//  ConfigurationView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//

import SwiftUI

struct ConfigurationView: View {
    @Environment(\.configuration) var configuration
    @State private var configurationManager = ConfigurationManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Environment Info
                VStack(spacing: 15) {
                    Text("Environment Configuration")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Environment:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(configurationManager.environmentName)
                                .foregroundColor(.blue)
                        }
                        
                        HStack {
                            Text("API Base URL:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(configuration.apiBaseURL)
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                        
                        HStack {
                            Text("API Version:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(configuration.apiVersion)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("App Name:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(configuration.appName)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Debug Mode:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text(configuration.debugMode ? "Enabled" : "Disabled")
                                .foregroundColor(configuration.debugMode ? .green : .red)
                        }
                        
                        HStack {
                            Text("Timeout:")
                                .fontWeight(.semibold)
                            Spacer()
                            Text("\(Int(configuration.timeoutInterval))s")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                
                // Environment URLs
                VStack(alignment: .leading, spacing: 10) {
                    Text("API Endpoints")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Login: \(configuration.authLoginURL)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("Apple Login: \(configuration.authAppleLoginURL)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("Hotels: \(configuration.hotelsURL)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                }
                
                Spacer()
                
                // Environment Switch Buttons
                VStack(spacing: 10) {
                    Button("Switch to Development") {
                        configurationManager.switchToDevelopment()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Switch to Production") {
                        configurationManager.switchToProduction()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Configuration")
        }
    }
}

#Preview {
    ConfigurationView()
} 
