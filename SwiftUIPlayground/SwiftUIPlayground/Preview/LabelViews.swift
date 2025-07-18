//
//  LabelViews.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//

import SwiftUI

struct LabelViews: View {
    
    var labelView: some View {
//        Label("Tab 1",systemImage: "eraser.badge.xmark")
//            .border(.foreground,
//                    width: 2.0)
//            .labelStyle(.titleAndIcon)
        Label() {
            Text("Name").frame(alignment: .leading)
        } icon: {
            CircleImage()
                .aspectRatio(1.0, contentMode: .fit)
        }
    }
    
    var body: some View {
        labelView
    }
}

#Preview {
    LabelViews()
}
