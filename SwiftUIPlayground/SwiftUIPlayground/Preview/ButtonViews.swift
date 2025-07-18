//
//  ButtonViews.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//

import SwiftUI


struct Floder: Identifiable {
    let id: UUID
    let title: String
}

struct ButtonViews: View {
    let folders: [ Floder] = [.init(id: .init(),
                                    title: "Name")]
    
    var buttonsView: some View {
       
        VStack {
            let sizes: [ControlSize] = [.extraLarge,.large,.mini,.regular,.small]
            ForEach(sizes, id: \.self) { size in
                Button("Size : \(size.description)") {
                    print("Button tapped !")
                }
//                .border(.foreground, width: 1.0)
                .controlSize(size)
                .buttonStyle(.glass)
                //.tint(.primary)
            }
        }
        .background(.red)
       
    }
    
    var buttonView: some View {
//        Button("Tapped me !") {
//            print("Button tapped !")
//        }
//        .border(.foreground, width: 1.0)

        List {
            ForEach(folders) { folder in
                Text(folder.title)
            }

            // A cell that, when selected, adds a new folder.
            Button(role: .destructive,  action: addItem) {
                Label("Add Folder", systemImage: "folder.badge.plus")
            }
            .contextMenu {
                Button("Menu 1", action: addItem)
            }
        }
    }
    
    var customButtonStyle: some View {
        Button("Tapped me !") {
                 print("Button tapped !")
        }.buttonStyle(.primaryStyle)
            .border(.blue, width: 1.0)
      
    }
    
    var body: some View {
        customButtonStyle
    }
        
    func addItem() {
        print("Add item")
    }
}


extension ControlSize {
    var description: String {
        switch self {
        case .mini:
            return "Mini"
        case .small:
            return "Small"
        case .regular:
            return "Regular"
        case .large:
            return "Large"
        case .extraLarge:
            return "ExtraLarge"
        @unknown default:
            return ""
        }
    }
}

struct PrimryButtoStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .background(.red)
            .clipShape(Rectangle())
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .foregroundColor(.green)
            .font(.body)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.smooth, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == PrimryButtoStyle {
    static var primaryStyle: PrimryButtoStyle { .init() }
}

#Preview {
    ButtonViews()
}
