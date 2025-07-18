//
//  ShapeViews.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//

import SwiftUI

struct ShapeViews: View {
    var reactangle: some View {
        ZStack {
            Rectangle()
                .stroke(Color.blue, lineWidth: 1)
                .fill(Color.red)
                .clipped()
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            Text("Hello, World!")
                .foregroundStyle(.white)
        }
        
    }
    
    var circle: some View {
        ZStack {
            Circle()
                .stroke(Color.blue, lineWidth: 1)
                .fill(Color.red)
                .clipped(antialiased: true)
            
            Text("Hello, World!")
                .foregroundStyle(.white)
        }
    }
    
    var roundedRectangle: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.blue, lineWidth: 1)
                .fill(Color.red)
                .clipped(antialiased: true)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            
            Text("Hello, World!")
                .foregroundStyle(.white)
        }
    }
    
    var capsule: some View {
        ZStack {
            Capsule(style: .circular)
                .stroke(Color.blue, lineWidth: 1)
                .fill(Color.red)
                .foregroundColor(Color.red)
                .clipped(antialiased: true)
            
            Text("Hello, World!")
                .foregroundStyle(.white)
        }
    }
    
    var ellipse: some View {
        ZStack {
            Ellipse()
                .stroke(Color.blue, lineWidth: 1)
                .fill(Color.red)
                .foregroundColor(Color.red)
                .clipped(antialiased: true)
            
            Text("Hello, World!")
                .foregroundStyle(.white)
        }
    }
    
    var triangle: some View {
        ZStack {
            Triangle()
                .stroke(Color.blue, lineWidth: 1)
                .fill(Color.red)
                .foregroundColor(Color.red)
                .clipped(antialiased: true)
                .opacity(0.7)
                .background(alignment: .centerLastTextBaseline) {
                    Text("asd")
                }
            
            Text("Hello, World!")
                .foregroundStyle(.white)
                .opacity(0.8)
                .overlay {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                        .padding(.top, 20)
                }.clipped()
                
        }
    }
    
    var body: some View {
        VStack {
            reactangle
            circle
            roundedRectangle
            capsule
            ellipse
            triangle
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

#Preview {
    ShapeViews()
}
