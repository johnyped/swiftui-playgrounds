//
//  EnvFileReader.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//

import Foundation

// MARK: - Environment File Reader
class EnvFileReader {
    static let shared = EnvFileReader()
    
    private var environmentVariables: [String: String] = [:]
    
    private init() {
        loadEnvironmentFile()
    }
    
    // MARK: - Load Environment File
    private func loadEnvironmentFile() {
        let fileName = getEnvironmentFileName()
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: nil),
              let content = try? String(contentsOfFile: path, encoding: .utf8) else {
            print("⚠️ Could not load environment file: \(fileName)")
            return
        }
        
        parseEnvironmentFile(content: content)
    }
    
    // MARK: - Get Environment File Name
    private func getEnvironmentFileName() -> String {
        #if DEBUG
        return ".env_dev"
        #else
        return ".env_prod"
        #endif
    }
    
    // MARK: - Parse Environment File
    private func parseEnvironmentFile(content: String) {
        let lines = content.components(separatedBy: .newlines)
        
        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Skip empty lines and comments
            if trimmedLine.isEmpty || trimmedLine.hasPrefix("#") {
                continue
            }
            
            // Parse key=value pairs
            if let range = trimmedLine.range(of: "=") {
                let key = String(trimmedLine[..<range.lowerBound]).trimmingCharacters(in: .whitespaces)
                let value = String(trimmedLine[range.upperBound...]).trimmingCharacters(in: .whitespaces)
                
                // Remove quotes if present
                let cleanValue = value.replacingOccurrences(of: "\"", with: "")
                    .replacingOccurrences(of: "'", with: "")
                
                environmentVariables[key] = cleanValue
            }
        }
    }
    
    // MARK: - Get Environment Variable
    func get(_ key: String, defaultValue: String = "") -> String {
        return environmentVariables[key] ?? defaultValue
    }
    
    // MARK: - Get Boolean Environment Variable
    func getBool(_ key: String, defaultValue: Bool = false) -> Bool {
        let value = get(key, defaultValue: defaultValue ? "true" : "false")
        return value.lowercased() == "true"
    }
    
    // MARK: - Get Double Environment Variable
    func getDouble(_ key: String, defaultValue: Double = 0.0) -> Double {
        let value = get(key, defaultValue: String(defaultValue))
        return Double(value) ?? defaultValue
    }
    
    // MARK: - Get Integer Environment Variable
    func getInt(_ key: String, defaultValue: Int = 0) -> Int {
        let value = get(key, defaultValue: String(defaultValue))
        return Int(value) ?? defaultValue
    }
    
    // MARK: - Debug Information
    func printEnvironmentVariables() {
        print("🌍 Environment Variables:")
        for (key, value) in environmentVariables.sorted(by: { $0.key < $1.key }) {
            print("  \(key) = \(value)")
        }
    }
}

// MARK: - Environment Configuration Extension
extension EnvironmentConfig {
    static func fromEnvFile() -> EnvironmentConfig {
        let env = EnvFileReader.shared
        
        return EnvironmentConfig(
            apiBaseURL: env.get("API_BASE_URL", defaultValue: "http://localhost"),
            apiVersion: env.get("API_VERSION", defaultValue: "v1"),
            appName: env.get("APP_NAME", defaultValue: "SwiftUIPlayground"),
            debugMode: env.getBool("DEBUG_MODE", defaultValue: false),
            timeoutInterval: env.getDouble("TIMEOUT_INTERVAL", defaultValue: 30.0)
        )
    }
} 
