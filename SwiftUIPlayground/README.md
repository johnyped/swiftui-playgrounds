# SwiftUI Login System

A complete SwiftUI login system with email/password and Apple ID authentication, featuring environment-based configuration management.

## Features
Pof of ENV App

## Configuration System

The app uses Xcode's native configuration system with xcconfig files and Info.plist for environment-specific settings.

### Product Schemes

The project includes two separate product schemes:

1. **SwiftUIPlayground DEV** - Development environment
   - Uses `Config/dev/dev.xcconfig`
   - Uses `InfoDev.plist`
   - Bundle ID: `com.swiftui.playground.SwiftUIPlayground`

2. **SwiftUIPlayground** - Production environment
   - Uses `Config/prod/prod.xcconfig`
   - Uses `Info.plist`
   - Bundle ID: `com.swiftui.playground.SwiftUIPlayground`

### Configuration Files

#### Development Configuration (`Config/dev/dev.xcconfig`)
```
APP_ENVIRONMENT = DEV
PMS_API_BASE_URL = https://dev.api.example.com
PMS_API_BASE_VERSION = v4
APP_NAME = SwiftUI Playground DEV
LOG_ENABLED = 0
```

#### Production Configuration (`Config/prod/prod.xcconfig`)
```
APP_ENVIRONMENT = PROD
PMS_API_BASE_URL = https://api.example.com
PMS_API_BASE_VERSION = v4
APP_NAME = SwiftUI Playground
LOG_ENABLED = 0
```

#### Info.plist Configuration
The Info.plist files reference xcconfig variables:
```xml
<key>APP_CONFIG</key>
<dict>
    <key>APP_ENVIRONMENT</key>
    <string>$(APP_ENVIRONMENT)</string>
    <key>APP_NAME</key>
    <string>$(APP_NAME)</string>
    <key>LOG_ENABLED</key>
    <string>$(LOG_ENABLED)</string>
    <key>PMS_API_BASE_URL</key>
    <string>$(PMS_API_BASE_URL)</string>
    <key>PMS_API_BASE_VERSION</key>
    <string>$(PMS_API_BASE_VERSION)</string>
</dict>
```

### Configuration Usage

The app loads configuration through the `EnvironmentConfig` class:

```swift
// Access configuration in SwiftUI views
@Environment(\.configuration) var configuration

// Get current environment
let environment = configuration.appEnvironment.environmentName

// Get API base URL
let apiURL = configuration.pmsApiBaseURL

// Check if logging is enabled
let isLoggingEnabled = configuration.logEnabled
```

### Configuration
- `EnvironmentConfig`: Loads and manages environment-specific configuration
- `ConfigurationManager`: Singleton manager for configuration access

## Usage

1. **Select the appropriate scheme**:
   - Choose "SwiftUIPlayground DEV" for development
   - Choose "SwiftUIPlayground" for production

2. **Run the app** on iOS device or simulator
3. The app will show the LoginView with two authentication options
4. Use either email/password or Apple ID to sign in
5. On successful authentication, you'll be navigated to HomeView
6. Use the logout button to clear tokens and return to login

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+
- Apple Developer Account (for Apple Sign In)

## Setup

1. Open the project in Xcode
2. **Select the appropriate scheme** for your target environment
3. Configure Apple Sign In capabilities in your app
4. **Update configuration values** in the respective xcconfig files if needed
5. Build and run on iOS device or simulator

## Configuration Management

### Adding New Configuration Values

1. **Add to xcconfig files**:
   ```
   NEW_CONFIG_VALUE = your_value
   ```

2. **Add to Info.plist**:
   ```xml
   <key>NEW_CONFIG_VALUE</key>
   <string>$(NEW_CONFIG_VALUE)</string>
   ```

3. **Update EnvironmentConfig.swift**:
   ```swift
   let newConfigValue: String
   
   init() {
       // ... existing code ...
       self.newConfigValue = appConfig?["NEW_CONFIG_VALUE"] as? String ?? ""
   }
   ```

### Switching Environments

- **Development**: Select "SwiftUIPlayground DEV" scheme
- **Production**: Select "SwiftUIPlayground" scheme
- The app will automatically load the appropriate configuration

## Notes

- The implementation includes proper error handling
- Tokens are securely stored in UserDefaults
- The UI follows iOS design guidelines
- All network calls are asynchronous
- The app handles loading states and user feedback
- Configuration is environment-specific and loaded at runtime
- The system supports easy switching between development and production environments 