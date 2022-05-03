//
//  NotificationManager.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 03/05/2022.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleAlarm(alarm: Alarm) {
        
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.subtitle = alarm.label
        content.body = "Wake up!"
        content.sound = UNNotificationSound.defaultRingtone
        
        let comps = Calendar.current.dateComponents([.hour, .second], from: alarm.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("error: \(error)")
            } else {
                print("Scheduled Notification")
            }
        }
    }
    
    func removeScheduledAlarm(alarm: Alarm) {
      UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [alarm.id.uuidString])
    }
 }
