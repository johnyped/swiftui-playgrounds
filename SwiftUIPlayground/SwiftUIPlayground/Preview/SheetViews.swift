//
//  SheetViews.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 17/7/2568 BE.
//

import SwiftUI

struct SheetViews: View {
    
    @State
    private var isPresentd: Bool = false
    
    
    
    var body: some View {
        List {
            Text("Sheet Views")
            Button("Present Sheet") {
                isPresentd = true
            }
            .buttonStyle(.bordered)
            .sheet(isPresented: $isPresentd) {
                print("on dissmis")
            } content: {
                SheetContentView()
            }

        }
    }
}

struct SheetContentView: View {
    // call to dismiss acton
    @Environment(\.dismiss)
    private var dismiss
            
    @State
    private var isOtherPresentd: Bool = false
    
    @State
    private var canDismiss: Bool = false

    var body: some View {
        VStack {
            Text("Hello, World! from sheet")

            Button("Dismiss") {
                dismiss()
            }

            Button("Open Other Sheet") {
                isOtherPresentd = true
            }
            .buttonStyle(.bordered)
        }
        .interactiveDismissDisabled(!canDismiss) // 👈 Prevent swipe dismiss if needed
        .onDisappear {
            print("Sheet was dismissed")
        }
        .sheet(isPresented: $isOtherPresentd) {
            print("on dissmis")
        } content: {
            SheetContentView()
                .presentationDetents([.height(200), .height(500), .fraction(1.0)])
        }
    }
}

#Preview {
    SheetViews()
}
