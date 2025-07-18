//
//  TextViews.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//

import SwiftUI

struct TextViews: View {
    
    
    var textView: some View {
        Text("SettingsView\nLine2\nLine3")
            .frame(width: 100, alignment: .trailing)
            .border(.foreground,
                    width: 2.0)
            //.lineLimit(2)
            .truncationMode(.tail)
            .font(.headline)
            .foregroundStyle(.red)
    }
    
    var body: some View {
        textView
    }
}

#Preview {
    TextViews()
}
