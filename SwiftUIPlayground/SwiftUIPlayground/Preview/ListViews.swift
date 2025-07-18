//
//  ListViews.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 17/7/2568 BE.
//

import SwiftUI

struct ListViews: View {
    
    @Binding var isExpanded: Bool
    @State private var selection: Set<String> = []
    
    let names: [String] = ["Apple", "Banana", "Orange", "Grape", "Pineapple"]
    
    var sectionListView: some View {
        List {
            Section(isExpanded: $isExpanded) {
                Text("Item 1")
                Text("Item 2")
            } header: {
                if $isExpanded.wrappedValue {
                    Text("Header 1")
                }
            }
            
            Section {
                Text("Item 1")
                Text("Item 2")
            } header: {
                Text("Header 2")
            }
        }
    }
    
    var selectionListView: some View {
        NavigationStack {
            List(selection: $selection) {
                ForEach(names, id: \.self) { name in
                    Text(name)
                }
            }.toolbar {
                Button("Clear") { selection.removeAll()
                }
                EditButton()
            }
        }
       
    }
    
    var body: some View {
        selectionListView
    }
}

#Preview {
    @Previewable @State
    var visible: Bool = true
    ListViews(isExpanded: $visible)
}
