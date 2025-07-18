//
//  ErrorSheet.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 18/7/2568 BE.
//
import SwiftUI

// MARK: - Error Sheet View
struct ErrorSheetView: View {
    let errorMessage: String
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text("Error")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(errorMessage)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button("OK") {
                onDismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding(30)
        .presentationDetents([.medium])
    }
}

//#Preview {
//    @Previewable @State var isPresented = false
//    Button("Show Error Sheet") {
//        isPresented = true
//    }.sheet(isPresented: $isPresented) {
//        ErrorSheetView(errorMessage: "Error Message") {
//            isPresented = false
//        }
//    }
//   
//}
