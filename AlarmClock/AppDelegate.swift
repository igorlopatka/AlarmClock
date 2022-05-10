//
//  AppDelegate.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 03/05/2022.
//

import SwiftUI
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Notification received with identifier \(notification.request.identifier)")
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        if response.actionIdentifier == "SNOOZE" {
            let content = UNMutableNotificationContent()
            content.title = "Alarm"
            content.body = "Snooze"
            
            content.sound = UNNotificationSound(named: UNNotificationSoundName("alarm.wav"))

            let comps = Calendar.current.dateComponents([.hour, .minute], from: Date().addingTimeInterval(60))
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
            let request = UNNotificationRequest(identifier: "snooze_id", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("error: \(error)")
                } else {
                    print("Scheduled Snooze")
                }
            }
        }
    }
}
