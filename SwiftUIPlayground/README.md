# SwiftUI Login System

A complete SwiftUI login system with email/password and Apple ID authentication.

## Features

### View Section 1: Email/Password Login
- Email and password input fields
- Login button with loading state and progress indicator
- Disables button during authentication
- Calls the auth API service asynchronously
- Routes to HomeView on successful login
- Shows error sheet on login failure
- Stores access_token in UserDefaults

### View Section 2: Apple ID Login
- Sign in with Apple button
- Integrates with Apple's AuthenticationServices framework
- Handles Apple credential authorization
- Calls Apple login API with credential data
- Stores access_token in UserDefaults
- Shows error sheet on failure

## API Integration

### Email/Password Login
- **Endpoint**: `POST http://157.230.37.164/api/v4/auth/login`
- **Request Body**:
  ```json
  {
    "username": "test1@email.com",
    "password": "12345678"
  }
  ```
- **Response**:
  ```json
  {
    "access_token": "eyJhbGciOiJIUzI1NiJ9...",
    "refresh_token": "d6f8b73993b104c1ffe06f290826d98e"
  }
  ```

### Apple ID Login
- **Endpoint**: `POST http://157.230.37.164/api/v4/auth/apple-login`
- **Request Body**:
  ```json
  {
    "code": "<string>",
    "first_name": "<string>",
    "last_name": "<string>",
    "email": "<string>"
  }
  ```

### Token Validation
- **Endpoint**: `GET http://157.230.37.164/api/v4/hotels`
- **Headers**: `Authorization: Bearer {{access_token}}`
- **Response**: HTTP 200 for valid token

## Architecture

### Models
- `LoginRequest`: Email/password login request
- `AppleLoginRequest`: Apple ID login request
- `LoginResponse`: API response with tokens
- `LoginError`: Error handling enum

### Services
- `AuthService`: Handles API calls for authentication
- `TokenManager`: Manages token storage in UserDefaults

### ViewModels
- `LoginViewModel`: Manages login state and business logic

### Views
- `LoginView`: Main login interface with two sections
- `HomeView`: Empty view for successful login
- `ErrorSheetView`: Error display sheet

## Usage

1. Run the app on iOS device or simulator
2. The app will show the LoginView with two authentication options
3. Use either email/password or Apple ID to sign in
4. On successful authentication, you'll be navigated to HomeView
5. Use the logout button to clear tokens and return to login

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+
- Apple Developer Account (for Apple Sign In)

## Setup

1. Open the project in Xcode
2. Configure Apple Sign In capabilities in your app
3. Build and run on iOS device or simulator

## Notes

- The implementation includes proper error handling
- Tokens are securely stored in UserDefaults
- The UI follows iOS design guidelines
- All network calls are asynchronous
- The app handles loading states and user feedback 