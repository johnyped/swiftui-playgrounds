//
//  SwiftUIPlaygroundApp.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 14/7/2568 BE.
//

import SwiftUI

@main
struct SwiftUIPlaygroundApp: App {
    @State private var configurationManager = ConfigurationManager.shared
    
    var body: some Scene {
    #if os(iOS)
        iOSRootScene()
            .environment(\.configuration, configurationManager.currentConfig)
    #elseif os(ipadOS)
        iPadRootScene()
            .environment(\.configuration, configurationManager.currentConfig)
    #elseif os(macOS)
        MacRootScene()
            .environment(\.configuration, configurationManager.currentConfig)
    #endif    
    }
}

