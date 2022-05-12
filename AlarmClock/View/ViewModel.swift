//
//  ContentVM.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 12/05/2022.
//

import Foundation
import CoreData

class ViewModel: ObservableObject {
    
    @Published var notification = NotificationManager()
    @Published var data = DataManager()
    
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
    
    func manageAlarmState(alarm: Alarm, isActive: Bool) {
        if isActive {
            notification.scheduleAlarm(alarm: alarm)
        } else {
            notification.removeScheduledAlarm(alarm: alarm)
        }
    }
    
    func updateView(){
        self.objectWillChange.send()
    }
}

