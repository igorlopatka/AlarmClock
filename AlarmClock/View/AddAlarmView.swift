//
//  AddAlarmView.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//

import SwiftUI

struct AddAlarmView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: ViewModel
    @State private var date = Date()
    @State private var label = ""
    
    var body: some View {
        NavigationView {
            List {
                TextField("Label", text: $label)
                    .padding()
                    .font(.largeTitle)
                DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
            }
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button() {
                        isPresented = false
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        viewModel.data.addAlarm(label: label, date: date)
                        viewModel.updateView()
                        isPresented = false
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
}
