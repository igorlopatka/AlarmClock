//
//  AlarmClockApp.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//

import SwiftUI

@main
struct AlarmClockApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
