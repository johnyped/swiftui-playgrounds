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
    }
    
    func reloadConfiguration() {
        self.config = EnvironmentConfig()
    }
    
}
