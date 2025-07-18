//
//  EnvironmentConfig.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//

import Foundation
import SwiftUI
import Yams

struct EnvironmentConfig: Decodable {
    
    enum anError: Error, LocalizedError {
        case fileNotFound
        case decodingFailed
        
        var errorDescription: String? {
            switch self {
            case .fileNotFound:
                return "Environment configuration file not found."
            case .decodingFailed:
                return "Failed to decode environment configuration."
            }
        }
    }
   
    let api: Self.Api
    let app: Self.App
    let features: Self.Features
    
    var fullAPIBaseURL: String {
        return "\(api.baseUrl)/api/\(api.version)"
    }
    
    var authLoginURL: String {
        return "\(fullAPIBaseURL)\(api.endpoints.authLogin)"
    }
    
    var authAppleLoginURL: String {
        return "\(fullAPIBaseURL)\(api.endpoints.authAppleLogin)"
    }
    
    var hotelsURL: String {
        return "\(fullAPIBaseURL)\(api.endpoints.hotels)"
    }
    
    // Helper method to get current environment name
    var environmentName: String {     
        #if DEBUG
        return "Development"
        #else
        return "Production"
        #endif
    }
    
    init() {
        do {
            self = try EnvironmentConfig.loadConfigurationFile()
        } catch {
            print(error.localizedDescription)
            fatalError("Failed to load required configuration values from YAML")
        }
    }
    
    // MARK: - Logging Helper
    func logValues() {
        print("🔧 Current Environment Configuration:")
        print("--------------------------------")
        print("API:")
        print("API Base URL: \(api.baseUrl)")
        print("API Version: \(api.version)")
        print("--------------------------------")
        print("App:")
        print("App Name: \(app.name)")
        print("Debug Mode: \(app.debugMode)")
        print("Timeout Interval: \(app.timeoutInterval)")
        print("--------------------------------")
        print("Features:")
        print("Logging Enabled: \(features.logging)")
        print("Analytics Enabled: \(features.analytics)")
        print("Crash Reporting Enabled: \(features.crashReporting)")
        print("--------------------------------")
        print("API Endpoints:")
        print("Auth Login: \(api.endpoints.authLogin)")
        print("Apple Login: \(api.endpoints.authAppleLogin)") 
        print("Hotels: \(api.endpoints.hotels)")
        print("--------------------------------")
        print("Full URLs:")
        print("Base API URL: \(fullAPIBaseURL)")
        print("Auth Login URL: \(authLoginURL)")
        print("Apple Login URL: \(authAppleLoginURL)")
        print("Hotels URL: \(hotelsURL)")
        print("--------------------------------")
    }
}

extension EnvironmentConfig {
    struct Api: Decodable {
        let baseUrl: String
        let version: String
        let endpoints: Endpoints
        
        enum CodingKeys: String, CodingKey {
            case baseUrl = "base_url"
            case version
            case endpoints = "endpoints"
        }
    }
    
    struct Endpoints: Decodable {
        let authLogin: String
        let authAppleLogin: String
        let hotels: String
        
        enum CodingKeys: String, CodingKey {
            case authLogin = "auth_login"
            case authAppleLogin = "auth_apple_login"
            case hotels
        }
    }
    
    struct App: Decodable {
        let name: String
        let debugMode: Bool
        let timeoutInterval: Double
        
        enum CodingKeys: String, CodingKey {
            case name
            case debugMode = "debug_mode"
            case timeoutInterval = "timeout_interval"
        }
    }
    
   struct Features: Decodable {
        let logging: Bool
        let analytics: Bool
        let crashReporting: Bool
        
        enum CodingKeys: String, CodingKey {
            case logging
            case analytics
            case crashReporting = "crash_reporting"
        }
    }
}

extension EnvironmentConfig {
    // MARK: - Load Configuration File
    static func loadConfigurationFile() throws -> EnvironmentConfig {
        let fileName = EnvironmentConfig.getConfigurationFileName()
        print("load environment config file: \(fileName)")
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: nil),
              let content = try? String(contentsOfFile: path, encoding: .utf8) else {
            print("⚠️ Could not load configuration file: \(fileName)")
            throw anError.fileNotFound
        }
        
        do {
            return try YAMLDecoder().decode(EnvironmentConfig.self, from: content)
        } catch {
            throw error
        }
    }
    
    // MARK: - Get Configuration File Name
    static func getConfigurationFileName() -> String {
        #if DEBUG
        return ".config/config_dev.yml"
        #else
        return ".config/config_prod.yml"    
        #endif
    }

}

// MARK: - SwiftUI Environment Key
struct ConfigurationKey: EnvironmentKey {
    static let defaultValue: EnvironmentConfig = EnvironmentConfig()
}

extension EnvironmentValues {
    var configuration: EnvironmentConfig {
        get { self[ConfigurationKey.self] }
        set { self[ConfigurationKey.self] = newValue }
    }
}

