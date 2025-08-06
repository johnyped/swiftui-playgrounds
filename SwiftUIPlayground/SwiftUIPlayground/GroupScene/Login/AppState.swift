//
//  AppState.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 6/8/2568 BE.
//
import Foundation
import Combine

class AppState: ObservableObject {
    @Published
    var isAuthenticated: Bool = false
    
    init(tokenStorage: TokenStorage = .shared) {
        
    }

}
