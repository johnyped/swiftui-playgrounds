//
//  HomeViewVM.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 10/8/2568 BE.
//
import Foundation
import SwiftUI

final class HomeViewVM {
    //var appState: AppState
    
    private var ts: TokenStorage
    
    init (ts: TokenStorage = .shared) {
        self.ts = ts
//        self.appState = AppState(tokenStorage: ts)
    }
    
    var isAuthenticated: Bool {
        ts.isAuthenticated
    }
    
    var accessToken: String? {
        ts.accessToken
    }
    
    var refreshToken: String? {
        ts.refreshToken
    }
    
//    init(appState: AppState) {
//        self.appState = appState
//    }
//    
    func clearToken() {
        //appState.tokenStorage.clearTokens()
        ts.clearTokens()
    }
    
    func debug() {
        //appState.debug()
    }
}
