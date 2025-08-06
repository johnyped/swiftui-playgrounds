//
//  TokenStorage.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 6/8/2568 BE.
//

import Combine
import Foundation

@Observable
class TokenStorage {
    static let shared = TokenStorage()

    var hasValidTokens: Bool {
        accessToken != nil && refreshToken != nil
    }

    private(set) var isAuthenticated: Bool

    private(set) var accessToken: String? {
        didSet {
            TokenStorage.saveAccessToken(accessToken)
        }
    }
    private(set) var refreshToken: String? {
        didSet {
            TokenStorage.saveRefreshToken(refreshToken)
        }
    }

    init() {
        // Load on first launch
        let accToken = TokenStorage.loadAccessToken()
        let refToken = TokenStorage.loadRefreshToken()
        
        self.accessToken = accToken
        self.refreshToken = refToken
        //        self.isAuthenticated = TokenStorage.isAlreadyAuthenticated(
        //            accessToken: self.accessToken,
        //            refreshToken: self.refreshToken
        //        )
        self.isAuthenticated =
            if let accToken,
                let refToken
            {
                true
                //!accToken.isEmpty && !refToken.isEmpty
            } else {
                false
            }
    }

    func updateTokens(
        access: String?,
        refresh: String?
    ) {
        self.accessToken = access
        self.refreshToken = refresh
        self.isAuthenticated = TokenStorage.isAlreadyAuthenticated(
            accessToken: self.accessToken,
            refreshToken: self.refreshToken
        )
    }

    func clearTokens() {
        self.accessToken = nil
        self.refreshToken = nil
        self.isAuthenticated = false
    }

}

extension TokenStorage {
    static func isAlreadyAuthenticated(
        accessToken: String?,
        refreshToken: String?
    ) -> Bool {
        if let accessToken,
            let refreshToken
        {
            return !accessToken.isEmpty && !refreshToken.isEmpty
        } else {
            return false
        }
    }

    static func loadAccessToken() -> String? {
        UserDefaults.standard.string(forKey: "accessToken")
    }

    static func saveAccessToken(_ token: String?) {
        if token == nil {
            UserDefaults.standard.removeObject(forKey: "accessToken")
            return
        }

        UserDefaults.standard.set(token, forKey: "accessToken")
    }

    static func loadRefreshToken() -> String? {
        UserDefaults.standard.string(forKey: "refreshToken")
    }

    static func saveRefreshToken(_ token: String?) {
        if token == nil {
            UserDefaults.standard.removeObject(forKey: "refreshToken")
            return
        }

        UserDefaults.standard.set(token, forKey: "refreshToken")
    }

}
