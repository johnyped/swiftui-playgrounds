//
//  AlertViews.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 17/7/2568 BE.
//

import SwiftUI

struct AlertViews: View {
    @Binding
    var isPresented: Bool
    
    var simpleAlertView: some View {
        Button("Show Alert") {
            self.isPresented.toggle()
        }
        .alert(isPresented: $isPresented) {
            Alert(
                title: Text("Hello"),
                message: Text("World"),
                dismissButton: Alert.Button.cancel({
                    print(">>> Cancel")
                })
            )
        }
    }
    
    var secoundControlAlertView: some View {
        Button("Show Alert") {
            self.isPresented.toggle()
        }
        .alert(isPresented: $isPresented) {
            Alert(
                title: Text("Hello"),
                message: Text("WorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorldWorld"),
                primaryButton: Alert.Button.default(Text("OK"), action: {
                    print(">>> OK")
                }), secondaryButton: Alert.Button.cancel() {
                    print(">>> Cancel")
                }
            )
        }
    }
    
    @State private var details: SaveDetails?
    
    var customButtonAlertView: some View {
        Button("Show Alert") {
            self.isPresented.toggle()
        }
        .alert(
            "Alert",
            isPresented: $isPresented,
            presenting: details
        ) { details in
            Button(role: .destructive) {
                // Handle the deletion.
            } label: {
                Text("Delete \(details.name)")
            }
            Button("Retry") {
                // Handle the retry action.
            }
        } message: { details in
            Text(details.error)
        }
//        .alert("Alert",
//               isPresented: $isPresented,
//               actions: {
//            
//            /// A destructive button that appears in red.
//              Button(role: .destructive) {
//                  // Perform the deletion
//              } label: {
//                  Text("Delete")
//              }
//              
//              /// A cancellation button that appears with bold text.
//              Button("Cancel", role: .cancel) {
//                  // Perform cancellation
//              }
//              
//              /// A general button.
//              Button("OK") {
//                  // Dismiss without action
//              }
//        }, message: {
//            Text("Hello World")
//        })
    }
    
    var body: some View {
        customButtonAlertView
    }
}

struct SaveDetails: Identifiable {
    let name: String
    let error: String
    let id = UUID()
}

struct SheetWithTextfieldView: View {
    @State private var showSheet = false
    @State private var name = ""

    var body: some View {
        Button("Show Input Alert") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            VStack(spacing: 20) {
                Text("Enter your name")
                    .font(.headline)
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("OK") {
                    print("Name entered: \(name)")
                    showSheet = false
                }
                .buttonStyle(.borderedProminent)
                Button("Cancel") {
                    showSheet = false
                }
                .foregroundColor(.red)
            }
            .padding()
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = false
    AlertViews(isPresented: $isPresented)
}
