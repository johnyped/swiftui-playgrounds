# Environment Configuration Setup

This document explains how to set up and use the environment configuration system in the SwiftUI app.

## Overview

The app uses a configuration system that allows you to manage different settings for development and production environments. This includes API URLs, feature flags, and other environment-specific configurations.

## Files Structure

```
SwiftUIPlayground/
├── .env_dev                    # Development environment configuration
├── .env_prod                   # Production environment configuration
└── SwiftUIPlayground/
    └── Config/
        ├── EnvironmentConfig.swift    # Environment configuration models
        ├── EnvFileReader.swift        # .env file parser
        └── ConfigurationView.swift    # Configuration UI
```

## Environment Files

### .env_dev (Development)
```bash
# Development Environment Configuration
API_BASE_URL=http://host
API_VERSION=v4
APP_NAME=SwiftUIPlayground Dev
DEBUG_MODE=true
TIMEOUT_INTERVAL=30.0

# API Endpoints
AUTH_LOGIN_ENDPOINT=/auth/login
AUTH_APPLE_LOGIN_ENDPOINT=/auth/apple-login
HOTELS_ENDPOINT=/hotels

# Feature Flags
ENABLE_LOGGING=true
ENABLE_ANALYTICS=false
ENABLE_CRASH_REPORTING=false
```

### .env_prod (Production)
```bash
# Production Environment Configuration
API_BASE_URL=https://api.production.com
API_VERSION=v4
APP_NAME=SwiftUIPlayground
DEBUG_MODE=false
TIMEOUT_INTERVAL=60.0

# API Endpoints
AUTH_LOGIN_ENDPOINT=/auth/login
AUTH_APPLE_LOGIN_ENDPOINT=/auth/apple-login
HOTELS_ENDPOINT=/hotels

# Feature Flags
ENABLE_LOGGING=false
ENABLE_ANALYTICS=true
ENABLE_CRASH_REPORTING=true
```

## Configuration System

### EnvironmentConfig
The main configuration struct that holds all environment-specific settings:

```swift
struct EnvironmentConfig {
    let apiBaseURL: String
    let apiVersion: String
    let appName: String
    let debugMode: Bool
    let timeoutInterval: TimeInterval
    
    // Computed properties for API endpoints
    var fullAPIBaseURL: String
    var authLoginURL: String
    var authAppleLoginURL: String
    var hotelsURL: String
}
```

### ConfigurationManager
A singleton class that manages the current environment configuration:

```swift
class ConfigurationManager: ObservableObject {
    static let shared = ConfigurationManager()
    @Published var currentConfig: EnvironmentConfig
    
    func switchToDevelopment()
    func switchToProduction()
    var environmentName: String
}
```

### EnvFileReader
A service that reads and parses .env files:

```swift
class EnvFileReader {
    static let shared = EnvFileReader()
    
    func get(_ key: String, defaultValue: String = "") -> String
    func getBool(_ key: String, defaultValue: Bool = false) -> Bool
    func getDouble(_ key: String, defaultValue: Double = 0.0) -> Double
    func getInt(_ key: String, defaultValue: Int = 0) -> Int
}
```

## SwiftUI Environment Integration

### Environment Key
The configuration is injected into SwiftUI's environment system:

```swift
struct ConfigurationKey: EnvironmentKey {
    static let defaultValue: EnvironmentConfig = EnvironmentConfig.development
}

extension EnvironmentValues {
    var configuration: EnvironmentConfig {
        get { self[ConfigurationKey.self] }
        set { self[ConfigurationKey.self] = newValue }
    }
}
```

### Usage in Views
Access the configuration in any SwiftUI view:

```swift
struct MyView: View {
    @Environment(\.configuration) var configuration
    
    var body: some View {
        Text("API URL: \(configuration.apiBaseURL)")
    }
}
```

### App Setup
Inject the configuration into the app's environment:

```swift
@main
struct SwiftUIPlaygroundApp: App {
    @StateObject private var configurationManager = ConfigurationManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.configuration, configurationManager.currentConfig)
        }
    }
}
```

## Build Configuration

The system automatically selects the appropriate environment based on the build configuration:

- **Debug builds**: Use `.env_dev` configuration
- **Release builds**: Use `.env_prod` configuration

This is handled by the `#if DEBUG` compiler directive in the `ConfigurationManager`.

## Adding New Configuration Values

1. **Add to .env files**:
   ```bash
   NEW_FEATURE_FLAG=true
   CUSTOM_TIMEOUT=45.0
   ```

2. **Update EnvironmentConfig**:
   ```swift
   struct EnvironmentConfig {
       // ... existing properties
       let newFeatureFlag: Bool
       let customTimeout: TimeInterval
   }
   ```

3. **Update static configurations**:
   ```swift
   static let development = EnvironmentConfig(
       // ... existing values
       newFeatureFlag: true,
       customTimeout: 45.0
   )
   ```

4. **Use in your code**:
   ```swift
   @Environment(\.configuration) var configuration
   
   if configuration.newFeatureFlag {
       // Enable new feature
   }
   ```

## ConfigurationView

The app includes a `ConfigurationView` that displays current environment settings and allows switching between environments at runtime. This is useful for testing and debugging.

## Best Practices

1. **Never commit sensitive data** to .env files
2. **Use meaningful default values** for all configuration properties
3. **Document new configuration options** in this file
4. **Test both environments** before deploying
5. **Use type-safe accessors** (getBool, getDouble, etc.) when reading from .env files

## Troubleshooting

### Configuration not loading
- Ensure .env files are added to the Xcode project
- Check that files are included in the app bundle
- Verify file names match exactly (.env_dev, .env_prod)

### Environment not switching
- Check that ConfigurationManager is properly injected
- Verify environment key is correctly set up
- Ensure views are using @Environment(\.configuration)

### Build configuration issues
- Verify DEBUG/RELEASE build settings in Xcode
- Check that #if DEBUG directives are working correctly
- Test with different build configurations 
