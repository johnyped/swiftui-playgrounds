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
    
    var config: EnvironmentConfig
    
    private init() {
        self.config = EnvironmentConfig()
        print("✅ Loaded configuration from YAML file")
    }
    
    func reloadConfiguration() {
        self.config = EnvironmentConfig()
        print("✅ Reloaded configuration from YAML file")
    }
    
}
