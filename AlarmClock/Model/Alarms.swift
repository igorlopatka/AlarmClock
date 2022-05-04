//
//  AlarmsList.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//

import Foundation

class Alarms: ObservableObject {
    @Published var list: [Alarm] = [
        // Default alarms
        Alarm(date: Calendar.current.date(from: DateComponents(hour: 7, minute: 00)) ?? Date.now, label: "Alarm", isActive: false, isSnooze: false),
        Alarm(date: Calendar.current.date(from: DateComponents(hour: 8, minute: 00)) ?? Date.now, label: "Alarm", isActive: false, isSnooze: false),
        Alarm(date: Calendar.current.date(from: DateComponents(hour: 9, minute: 00)) ?? Date.now, label: "Alarm",isActive: false, isSnooze: false)
        ]
}
