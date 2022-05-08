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
                print("Permission granted.")
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
        content.sound = UNNotificationSound.defaultCritical
        
        let id = alarm.id.uuidString
        let comps = Calendar.current.dateComponents([.day, .hour, .minute], from: alarm.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("error: \(error)")
            } else {
                print("Scheduled Notification, \(id) ")
            }
        }
    }
    
    func removeScheduledAlarm(alarm: Alarm) {
        let id = alarm.id.uuidString
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [id])
    }
}
