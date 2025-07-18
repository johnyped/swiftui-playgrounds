# YAML Configuration Migration

This document describes the migration from `.env` files to YAML configuration files.

## Overview

The configuration system has been updated to use YAML format instead of `.env` files. This provides better structure, type safety, and readability.

## File Structure

### Old Structure (.env files)
```
.env_dev
.env_prod
```

### New Structure (YAML files)
```
config_dev.yml
config_prod.yml
```

## YAML Configuration Format

### Development Configuration (`config_dev.yml`)
```yaml
# Development Environment Configuration
api:
  base_url: "http://157.230.37.164"
  version: "v4"
  endpoints:
    auth_login: "/auth/login"
    auth_apple_login: "/auth/apple-login"
    hotels: "/hotels"

app:
  name: "SwiftUIPlayground Dev"
  debug_mode: true
  timeout_interval: 30.0

features:
  logging: true
  analytics: false
  crash_reporting: false
```

### Production Configuration (`config_prod.yml`)
```yaml
# Production Environment Configuration
api:
  base_url: "https://api.production.com"
  version: "v4"
  endpoints:
    auth_login: "/auth/login"
    auth_apple_login: "/auth/apple-login"
    hotels: "/hotels"

app:
  name: "SwiftUIPlayground"
  debug_mode: false
  timeout_interval: 60.0

features:
  logging: false
  analytics: true
  crash_reporting: true
```

## Implementation Details

### New Classes

1. **SimpleYAMLReader**: A lightweight YAML parser that doesn't require external dependencies
2. **Updated EnvironmentConfig**: Enhanced to support feature flags and API endpoints
3. **Updated ConfigurationManager**: Now loads from YAML first, falls back to .env, then defaults

### Backward Compatibility

The system maintains backward compatibility with existing `.env` files. The loading order is:
1. YAML configuration files
2. `.env` files (fallback)
3. Default hardcoded values

### Usage

```swift
// Get configuration from YAML
let config = ConfigurationManager.shared.currentConfig

// Access configuration values
let apiURL = config.apiBaseURL
let isDebug = config.debugMode
let enableLogging = config.enableLogging

// Reload configuration
ConfigurationManager.shared.reloadConfiguration()
```

## Migration Steps

1. ✅ Convert `.env_dev` to `config_dev.yml`
2. ✅ Convert `.env_prod` to `config_prod.yml`
3. ✅ Update configuration reader to parse YAML
4. ✅ Maintain backward compatibility with `.env` files
5. ✅ Update ConfigurationManager to use new system

## Benefits

- **Better Structure**: Hierarchical configuration with clear sections
- **Type Safety**: Strongly typed configuration values
- **Readability**: YAML is more human-readable than key-value pairs
- **Extensibility**: Easy to add new configuration sections
- **Validation**: Better error handling and validation

## Future Enhancements

To add the Yams library for more robust YAML parsing:

1. Add Yams package to the project:
   - In Xcode: File → Add Package Dependencies
   - URL: `https://github.com/jpsim/Yams.git`

2. Replace SimpleYAMLReader with Yams-based implementation for:
   - Better YAML compliance
   - Support for complex YAML features
   - Better error messages

## Testing

To test the configuration:

```swift
// Print current configuration
SimpleYAMLReader.shared.printConfiguration()

// Check configuration source
let source = ConfigurationManager.shared.configurationSource
print("Configuration source: \(source)")
``` 