//
//  EditModeView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//

import SwiftUI

struct EditModeView: View {
    
    @State
    var isEditing = false
    
    @State
    var friuts: [String] = [
        "Apple",
        "Banana",
        "C"
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(friuts, id: \.self) { fruit in
                    Text(fruit)
                }
                .onMove(perform: {
                    self.friuts.move(fromOffsets: $0, toOffset: $1)
                })
                .onDelete(perform: { offsets in
                    self.friuts.remove(atOffsets: offsets)
                })
            }
            .navigationBarTitle("EditModeView")
            .toolbar {
                Button("BTN",
                       role: .none) {
                    print(#function)
                }
                EditButton()
                
            }
        }
        Text("ABC")
    }
}

#Preview {
    EditModeView()
}
