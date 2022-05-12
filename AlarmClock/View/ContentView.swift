//
//  ContentView.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//

import CoreData
import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @StateObject private var viewModel = ContentVM()
    @State private var isAddingAlarm = false
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    var fetchRequest = FetchRequest<Alarm>(entity: Alarm.entity(), sortDescriptors:
    [NSSortDescriptor(keyPath: \Alarm.date, ascending: true)])
    var alarms: FetchedResults<Alarm> { fetchRequest.wrappedValue }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(alarms, id: \.self) { alarm in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(alarm.date!, formatter: viewModel.timeFormat)
                                .font(.largeTitle)
                            Text(alarm.label!)
                        }
                        Spacer()
                        Toggle("Activate alarm", isOn: Binding<Bool>(get: {
                            alarm.isActive?.boolValue == true
                        }, set: { value in
                            alarm.isActive = NSNumber(value: value)
                            viewModel.manageAlarmState(alarm: alarm, isActive: value)
                        }))
                        .labelsHidden()
                    }
                }
                .onDelete(perform: deleteAlarm)
                .onAppear(perform: {
                    viewModel.notification.requestPermission()
                })
            }
            .sheet(isPresented: $isAddingAlarm) {
                AddAlarmView(isPresented: $isAddingAlarm)
            }
            .navigationBarTitle("AlarmClock")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        isAddingAlarm.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func deleteAlarm(offsets: IndexSet) {
        withAnimation {
            offsets.map { alarms[$0] }.forEach(context.delete)
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
