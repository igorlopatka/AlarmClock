//
//  ContentView.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//


import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    @State private var isAddingAlarm = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.data.alarms, id: \.self) { alarm in
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
                .onDelete(perform: viewModel.data.deleteAlarm)
                .onAppear(perform: {
                    viewModel.notification.requestPermission()
                    viewModel.data.getAlarms()
                    viewModel.updateView()
                })
            }
            .sheet(isPresented: $isAddingAlarm) {
                AddAlarmView(isPresented: $isAddingAlarm, viewModel: viewModel)
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
}

