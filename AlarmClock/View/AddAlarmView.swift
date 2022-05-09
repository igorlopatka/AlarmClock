//
//  AddAlarmView.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//

import SwiftUI

struct AddAlarmView: View {
    
    @Binding var isPresented: Bool
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
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
                        addRun(title: label, date: date)
                    } label: {
                        Text("Save")
                    }
                }
            }
        }
    }
    
    private func addRun(title: String, date: Date) {
        withAnimation {
            let newAlarm = Alarm(context: context)
            newAlarm.date = date
            newAlarm.id = UUID()
            newAlarm.label = title
            newAlarm.isActive = false
            newAlarm.isSnooze = false
            do {
                try context.save()
                cancel()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func cancel() {
        isPresented = false
    }
}
