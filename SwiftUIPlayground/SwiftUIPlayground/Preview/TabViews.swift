//
//  TabViews.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 17/7/2568 BE.
//

import SwiftUI

struct TabViews: View {
    
    @State private var selectedTabIndex = 2
    
    // .sidebarAdaptable fit for ipadOS
    var tabViewWithPageStyle: some View {
        TabView(selection: $selectedTabIndex) {
            Tab("Tab 1",systemImage: "heart",value: 0) {
                Text("Page 1")
            }
            .badge(2)
            Tab("Tab 2",systemImage: "pencil",value: 1) {
                Text("Page 2")
            }
           
            TabSection("Extra Tab Section") {
                Tab("Tab 3",systemImage: "square.and.arrow.up",value: 2) {
                    Text("Page 3")
                }
                Tab("Tab 4",systemImage: "gear",value: 2) {
                    Text("Page 4")
                }.defaultVisibility(.hidden,
                                    for: .tabBar) // hidden for ipad
            }.sectionActions {
                Button("Action") {
                    
                }
            }
            
            Tab("Tab 5",systemImage: "magnifyingglass",value: 3,role: .search) {
                Text("Page 5")
            }
          
        }.tabViewStyle(.tabBarOnly)
    }
    
    var body: some View {
        tabViewWithPageStyle
    }
}

#Preview {
    TabViews()
}
