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
      let formatter = DateFormatter()
      formatter.dateFormat = "h:mm"
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
        
        content.sound = UNNotificationSound.default
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
