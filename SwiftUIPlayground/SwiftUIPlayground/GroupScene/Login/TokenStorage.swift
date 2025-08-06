//
//  TokenStorage.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 6/8/2568 BE.
//

import Combine
import Foundation

class TokenStorage: ObservableObject {
    static let shared = TokenStorage()

    @Published
    private(set) var isAuthenticated: Bool

    @Published
    private(set) var accessToken: String? {
        didSet {
            UserDefaults.standard.set(accessToken, forKey: "accessToken")
        }
    }

    @Published
    private(set) var refreshToken: String? {
        didSet {
            UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
        }
    }

    private init() {
        // Load on first launch
        let _accessToken = UserDefaults.standard.string(forKey: "accessToken")
        let _refreshToken = UserDefaults.standard.string(forKey: "refreshToken")
        self.accessToken = _accessToken
        self.refreshToken = _refreshToken

        isAuthenticated =
            if let _accessToken,
                let _refreshToken
            {
                _accessToken.count > 0 && _refreshToken.count > 0
            } else { false }

    }

    func updateTokens(access: String?, refresh: String?) {
        self.accessToken = access
        self.refreshToken = refresh
        self.isAuthenticated =
            if let access,
                let refresh
            {
                access.count > 0 && refresh.count > 0
            } else { false }
    }

    func clearTokens() {
        self.accessToken = nil
        self.refreshToken = nil
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        
        isAuthenticated = false
    }

    var hasValidTokens: Bool {
        accessToken != nil && refreshToken != nil
    }
}
