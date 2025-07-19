//
//  EnvironmentConfig.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//

import Foundation
import SwiftUI

struct EnvironmentConfig: Decodable {   
    let appEnvironment: AppEnvironment
    let pmsApiBaseUrl: String
    let pmsApiVersion: String
    
    let appName: String
    
    let logEnabled: Bool
    
  
   var pmsApiBaseURL: String {
       return "\(pmsApiBaseUrl)/api/\(pmsApiVersion)"
   }
    
    init(appEnvironment: String,
         pmsApiBaseUrl: String,
         pmsApiVersion: String,
         appName: String,
         logEnabled: Bool) {
        self.appEnvironment = .init(rawValue: appEnvironment)
        self.pmsApiBaseUrl = pmsApiBaseUrl
        self.pmsApiVersion = pmsApiVersion
        self.appName = appName
        self.logEnabled = logEnabled
    }
        
    init() {
        let dict = Bundle.main.infoDictionary
        let appConfig = dict?["APP_CONFIG"] as? [String: Any]
        
        let appEnvironment = appConfig?["APP_ENVIRONMENT"] as? String ?? ""
        self.appEnvironment = .init(rawValue: appEnvironment)
        
        self.pmsApiBaseUrl = appConfig?["PMS_API_BASE_URL"] as? String ?? ""
        self.pmsApiVersion = appConfig?["PMS_API_BASE_VERSION"] as? String ?? ""
        self.appName = appConfig?["APP_NAME"] as? String ?? ""
        self.logEnabled = (appConfig?["LOG_ENABLED"] as? String ?? "0") == "1"
    }
    
    // MARK: - Logging Helper
    func logValues() {
        print("🔧 Current Environment Configuration:")
        print("--------------------------------")
        print("Environment: \(appEnvironment.environmentName)")
        print("--------------------------------")
        print("API:")
        print("API Base URL: \(pmsApiBaseUrl)")
        print("API Version: \(pmsApiVersion)")
        print("Full API Base URL: \(pmsApiBaseURL)")
        print("--------------------------------")
        print("App:")
        print("App Name: \(appName)")
        print("Logging Enabled: \(logEnabled)")
        print("--------------------------------")
    }
}

extension EnvironmentConfig {
    enum AppEnvironment: String, Decodable {
        case development = "DEV"
        case production = "PROD"
        
        var environmentName: String {
            switch self {
            case .development:
                return "Development"
            case .production:
                return "Production"
            }
        }
        
        init(rawValue: String) {
            switch rawValue.uppercased() {
            case AppEnvironment.development.rawValue:
                self = .development
            case AppEnvironment.production.rawValue:
                self = .production
            default:
                fatalError("invalid environment raw value: \(rawValue)")
            }
        }
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

