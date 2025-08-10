//
//  LoginViewVM.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 10/8/2568 BE.
//
import Foundation
import SwiftUI

final class LoginViewVM {
    //    var appState: AppState
    //

    //    init(appState: AppState) {
    //        self.appState = appState
    //    }

    var ts: TokenStorage

    var isAuthenticated: Bool {
        ts.isAuthenticated
    }

    var accessToken: String? {
        ts.accessToken
    }

    var refreshToken: String? {
        ts.refreshToken
    }

    init(ts: TokenStorage = .shared) {
        self.ts = ts
    }

    func updateTokens(
        accessToken: String,
        refreshToken: String
    ) {
        //        appState.tokenStorage.updateTokens(
        //            access: accessToken,
        //            refresh: refreshToken
        //        )
        //let ts = TokenStorage.shared
        ts.updateTokens(
            access: accessToken,
            refresh: refreshToken
        )
    }

    func debug() {
        //appState.debug()
    }
}
