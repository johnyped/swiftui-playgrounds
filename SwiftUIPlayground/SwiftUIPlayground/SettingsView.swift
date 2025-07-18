//
//  SettingsView.swift
//  SwiftUIPlayground
//
//  Created by IntrodexMini on 16/7/2568 BE.
//
import SwiftUI

struct SettingsView: View {
    
    var datepickerView: some View {
        DatePicker("Select Date", selection: .constant(Date()))
    }
    
    var body: some View {
        datepickerView
    }
    
    func addItem() {
        print("Add item")
    }
}


