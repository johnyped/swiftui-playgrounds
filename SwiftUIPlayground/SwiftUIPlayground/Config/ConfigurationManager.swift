//
//  ConfigurationManager.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//
import SwiftUI

// MARK: - Configuration Manager
@Observable
class ConfigurationManager {
    static let shared = ConfigurationManager()
    
    var currentConfig: EnvironmentConfig
    
    private init() {
        #if DEBUG
        self.currentConfig = EnvironmentConfig.development
        #else
        self.currentConfig = EnvironmentConfig.production
        #endif
    }
    
    func switchToDevelopment() {
        currentConfig = EnvironmentConfig.development
    }
    
    func switchToProduction() {
        currentConfig = EnvironmentConfig.production
    }
    
    // Helper method to get current environment name
    var environmentName: String {
        #if DEBUG
        return "Development"
        #else
        return "Production"
        #endif
    }
}
