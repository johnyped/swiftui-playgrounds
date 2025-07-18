//
//  EnvironmentConfig.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//

import Foundation
import SwiftUI

struct EnvironmentConfig {
    let apiBaseURL: String
    let apiVersion: String
    let appName: String
    let debugMode: Bool
    let timeoutInterval: TimeInterval
    
    static let development = EnvironmentConfig(
        apiBaseURL: "http://api.dev.com",
        apiVersion: "v4",
        appName: "SwiftUIPlayground Dev",
        debugMode: true,
        timeoutInterval: 30.0
    )
    
    static let production = EnvironmentConfig(
        apiBaseURL: "https://api.production.com",
        apiVersion: "v4",
        appName: "SwiftUIPlayground",
        debugMode: false,
        timeoutInterval: 60.0
    )
    
    var fullAPIBaseURL: String {
        return "\(apiBaseURL)/api/\(apiVersion)"
    }
    
    var authLoginURL: String {
        return "\(fullAPIBaseURL)/auth/login"
    }
    
    var authAppleLoginURL: String {
        return "\(fullAPIBaseURL)/auth/apple-login"
    }
    
    var hotelsURL: String {
        return "\(fullAPIBaseURL)/hotels"
    }
}

// MARK: - SwiftUI Environment Key
struct ConfigurationKey: EnvironmentKey {
    static let defaultValue: EnvironmentConfig = EnvironmentConfig.development
}

extension EnvironmentValues {
    var configuration: EnvironmentConfig {
        get { self[ConfigurationKey.self] }
        set { self[ConfigurationKey.self] = newValue }
    }
} 
