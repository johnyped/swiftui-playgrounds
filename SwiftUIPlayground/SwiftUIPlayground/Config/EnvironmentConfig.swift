//
//  EnvironmentConfig.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//

import Foundation
import SwiftUI

struct EnvironmentConfig: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case appEnvironment = "APP_ENVIRONMENT"
        case pmsApiBaseUrl = "PMS_API_BASE_URL"
        case pmsApiVersion = "PMS_API_BASE_VERSION"
        case appName = "APP_NAME"
        case logEnabled = "LOG_ENABLED"
    }
    
    let appEnvironment: AppEnvironment
    let pmsApiBaseUrl: String
    let pmsApiVersion: String
    
    let appName: String
    
    let logEnabled: Bool
    
//    // Computed property to get Bool value
//    var isLogEnabled: Bool {
//        return logEnabled == "1"
//    }
  
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
        guard let dict = Bundle.main.infoDictionary,
              let appConfigData = dict["APP_CONFIG"] as? [String: Any] else {
            fatalError("fail on load app config")
        }
        do {
            print("🔧 App Config Data:")
            print("--------------------------------")
            if let jsonString = String(data: try JSONSerialization.data(withJSONObject: appConfigData, options: .prettyPrinted), encoding: .utf8) {
                print(jsonString)
            }
            print("--------------------------------")
            let jsonData = try JSONSerialization.data(withJSONObject: appConfigData)            
            self = try JSONDecoder().decode(EnvironmentConfig.self, from: jsonData)
        }
        catch {
            fatalError("fail on load app config, reason: \(error)")
        }
    }
    
    // decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.appEnvironment = try container.decode(AppEnvironment.self, forKey: .appEnvironment)
        self.pmsApiBaseUrl = try container.decode(String.self, forKey: .pmsApiBaseUrl)
        self.pmsApiVersion = try container.decode(String.self, forKey: .pmsApiVersion)
        self.appName = try container.decode(String.self, forKey: .appName)
        self.logEnabled = try container.decode(String.self, forKey: .logEnabled) == "1"
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

