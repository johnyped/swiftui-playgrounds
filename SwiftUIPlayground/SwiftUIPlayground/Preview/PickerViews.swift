//
//  PickerViews.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//

import SwiftUI

enum PickerOption: Identifiable {
    case name
    case lastName
    case email
    
    var value: String {
        switch self {
        case .name:
            return "Name"
        case .lastName:
            return "Lastname"
        case .email:
            return "Email"
        }
    }
    
    var id: Self { self }
}

struct PickerViews: View {
    @State
    var options: [PickerOption] = [
        .name, .lastName, .email
    ]
    
    @State
    var selectedOption: PickerOption = .name
    
    let pickerStyles: [any PickerStyle] = [
        DefaultPickerStyle(),
        SegmentedPickerStyle(),
        WheelPickerStyle(),
        MenuPickerStyle(),
        InlinePickerStyle(),
        NavigationLinkPickerStyle(),
        PalettePickerStyle()
    ]
    
    var body: some View {
        List {
            Section("Section A") {
                Picker("Automatic", selection: $selectedOption) {
                    Text(PickerOption.name.value).tag(PickerOption.name)
                    Text(PickerOption.lastName.value).tag(PickerOption.lastName)
                    Text(PickerOption.email.value).tag(PickerOption.email)
                }
                .pickerStyle(.automatic)
            }
            
            Section {
                Picker("Inline", selection: $selectedOption) {
                    Text(PickerOption.name.value).tag(PickerOption.name)
                    Text(PickerOption.lastName.value).tag(PickerOption.lastName)
                    Text(PickerOption.email.value).tag(PickerOption.email)
                }
                .pickerStyle(.inline)
            }
            
            Section {
                Picker("Menu", selection: $selectedOption) {
                    Text(PickerOption.name.value).tag(PickerOption.name)
                    Text(PickerOption.lastName.value).tag(PickerOption.lastName)
                    Text(PickerOption.email.value).tag(PickerOption.email)
                }
                .pickerStyle(.menu)
            }
            
            Section {
                Picker("NavigationLink", selection: $selectedOption) {
                    Text(PickerOption.name.value).tag(PickerOption.name)
                    Text(PickerOption.lastName.value).tag(PickerOption.lastName)
                    Text(PickerOption.email.value).tag(PickerOption.email)
                }
                .pickerStyle(.navigationLink)
            }
            
            Section {
                Picker("Palette", selection: $selectedOption) {
                    Text(PickerOption.name.value).tag(PickerOption.name)
                    Text(PickerOption.lastName.value).tag(PickerOption.lastName)
                    Text(PickerOption.email.value).tag(PickerOption.email)
                }
                .pickerStyle(.palette)
            }
            
            Section {
                Picker("Segmented", selection: $selectedOption) {
                    Text(PickerOption.name.value).tag(PickerOption.name)
                    Text(PickerOption.lastName.value).tag(PickerOption.lastName)
                    Text(PickerOption.email.value).tag(PickerOption.email)
                }
                .pickerStyle(.segmented)                
            }
            
            Section {
                Picker("Wheel", selection: $selectedOption) {
                    Text(PickerOption.name.value).tag(PickerOption.name)
                    Text(PickerOption.lastName.value).tag(PickerOption.lastName)
                    Text(PickerOption.email.value).tag(PickerOption.email)
                }
                .pickerStyle(.wheel)
            }
        }
    }
}
    
#Preview {
    PickerViews()
}
