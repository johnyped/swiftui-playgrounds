//
//  SettingsView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//
import SwiftUI

struct SettingsView: View {
    
    @ViewBuilder
    var datepickerView: some View {
        #if os(iOS) || os(macOS) || os(watchOS)
        DatePicker("Select Date", selection: .constant(Date()))
        #elseif os(tvOS)
        // DatePicker is unavailable on tvOS. Provide a simple fallback UI.
        VStack(alignment: .leading, spacing: 12) {
            Text("Select Date")
                .font(.headline)
            Text(Date().formatted(date: .abbreviated, time: .omitted))
                .font(.body)
                .foregroundStyle(.secondary)
            Text("Date selection is not available on tvOS.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        #else
        // Fallback for any other platforms
        Text("Date selection not available on this platform.")
        #endif
    }
    
    var body: some View {
        datepickerView
    }
    
    func addItem() {
        print("Add item")
    }
}
