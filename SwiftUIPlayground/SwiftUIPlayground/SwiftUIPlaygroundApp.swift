//
//  SwiftUIPlaygroundApp.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 14/7/2568 BE.
//

import SwiftUI

@main
struct SwiftUIPlaygroundApp: App {        
    
    var body: some Scene {
    #if os(iOS)
        iOSRootScene()
    #elseif os(ipadOS)
        iPadRootScene()
    #elseif os(macOS)
        MacRootScene()
    #endif    
    }
}

