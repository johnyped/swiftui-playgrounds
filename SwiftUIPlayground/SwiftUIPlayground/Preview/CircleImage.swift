//
//  CircleImage.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 15/7/2568 BE.
//

import SwiftUI
import UIKit

struct CircleImage: View {
    
    var circleImage: some View {
        Image("profile")
            .resizable(resizingMode: .stretch)
            .clipShape(.circle)
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
    
    var imageFromUIImage: some View {
        Image(uiImage: UIImage(named: "profile")!)
    }
    
    var width: CGFloat {
        150
    }
    var height: CGFloat {
        200
    }
    var ratio: CGFloat {
        width/height
    }
    
    let url = URL(string: "https://docs-assets.developer.apple.com/published/b9eb95d171c2788bfbc48c0f8bbfca49/foundations-typography-intro~dark%402x.png")!
    
    var loadedImage: some View {
        AsyncImage(url: url) { status in
            switch status {
            case .empty:
                Text("Empty")
            case .success(let img):
                img
                    .resizable()
                    .interpolation(.none)
                    .aspectRatio(contentMode: .fit)
                    .clipped(antialiased: true)
                    .frame(width: width, height: height)
            case .failure(let error):
                Text("Falure !")
            @unknown default:
                fatalError()
            }
        }        
    }
    
    var body: some View {
        //circleImage
        ZStack(alignment: .top) {
            Image("profile")
                .resizable()
                .interpolation(.none)
                //.aspectRatio(ratio, contentMode: .fit)
                .aspectRatio(contentMode: .fill)
                .clipped(antialiased: true)
                .frame(width: width, height: height)
            
            loadedImage
                
            
            Text("TextTextTextTextTextTextText")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .padding(.top, 10)
                .frame(width: .infinity, alignment: .center)
        }.edgesIgnoringSafeArea(.all)
        
        
    }
}


#Preview {
    CircleImage()
}
