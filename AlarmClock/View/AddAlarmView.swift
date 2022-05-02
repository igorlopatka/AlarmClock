//
//  AddAlarmView.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//

import SwiftUI

struct AddAlarmView: View {
    
    @ObservedObject var alarms: Alarms
    @Binding var isPresented: Bool
    
    @State private var date = Date()
    @State private var label = ""
    @State private var isSnoozing = false
    
    var body: some View {
        NavigationView {
            List {
                TextField("Label", text: $label)
                    .padding()
                    .font(.largeTitle)
                DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                Toggle("Snooze", isOn: $isSnoozing)
            }
            .listStyle(.grouped)
//            .navigationTitle("New alarm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button() {
                        cancel()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        addAlarm()
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
    
    private func addAlarm() {
        let newAlarm = Alarm(
            date: date,
            label: label,
            isActive: true,
            isSnooze: isSnoozing)
        
        alarms.list.append(newAlarm)
        isPresented = false
    }
    
    private func cancel() {
        isPresented = false
    }
}
