//
//  MenuViews.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//
import SwiftUI

struct MenuViews: View {
    
    var menuInMenu: some View {
        
        Menu {
            Section("Actions") {
                // sub title menu
                Button(action: {}) {
                    Text("Copy")
                    Text("Make a copy of this item")
                }
                Button(action: {}) {
                    Label("PDF", systemImage: "doc.fill")
                    Text("Make a PDF")
                }
                
                Button(action: {}) {
                    Text("Link")
                }
                
              
                
                Menu("More") {
                    Button(action: {}) {
                        Text("Delete")
                    }
                    Button(action: {}) {
                        Text("Rename")
                    }
                }
            }.foregroundStyle(.gray)
            
            Section("Other") {
                Menu("More") {
                    Button(action: {}) {
                        Text("Delete")
                    }
                    Divider()
                    Button(action: {}) {
                        Text("Rename")
                    }
                }
            }
           
        } label: {
            Label("Show Menu", systemImage: "doc.fill")
        }
        //            primaryAction: {
        //                print(">>> primaryAction")
        //            }
        
    }
    
    @Environment(\.openURL) private var openURL
    
    var link: some View {
        Link("OpenGoogle", destination: URL(string: "https://www.google.com")!)
    }
    
    var body: some View {
        
        List {
            link
            menuInMenu
        }
    }
}

#Preview {
    MenuViews()
}
