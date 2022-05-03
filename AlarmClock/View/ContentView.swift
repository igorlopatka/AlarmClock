//
//  ContentView.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
        
    @StateObject var alarms = Alarms()
    @State private var isAddingAlarm = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(alarms.list.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(self.alarms.list[index].date, formatter: timeFormat)
                                .font(.largeTitle)
                            Text(self.alarms.list[index].label)
                        }
                        Toggle("", isOn: self.$alarms.list[index].isActive)
                    }
                }
                .onDelete(perform: delete)
                .onChange(of: alarms.list) { updatedList in
                    for alarm in alarms.list {
                        if alarm.isActive {
                            print("Alarm active, \(timeFormat.string(from: alarm.date))")
                            scheduleAlarm(date: alarm.date)
                        } else {
                            
                        }
                    }
                }
            }
            .sheet(isPresented: $isAddingAlarm) {
                AddAlarmView(alarms: alarms, isPresented: $isAddingAlarm)
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
            .onAppear {
                requestPermission()
            }
        }
    }
    
    let timeFormat: DateFormatter = {
        
        let dateAsString = "6:35 PM"
        let formatter = DateFormatter()
        
        formatter.dateFormat = "h:mm a"
        let date = formatter.date(from: dateAsString)

        formatter.dateFormat = "HH:mm"
        let date24 = formatter.string(from: date!)
        
        
        let calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = calendar.timeZone
        
        return formatter
    }()
    
    func delete(at offsets: IndexSet) {
        alarms.list.remove(atOffsets: offsets)
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleAlarm(date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        
        let dateString = timeFormat.string(from: date)
        content.subtitle = dateString
        
        content.sound = UNNotificationSound.defaultRingtone
        
        let comps = Calendar.current.dateComponents([.hour, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("error: \(error)")
            } else {
                print("Scheduled Notification")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
