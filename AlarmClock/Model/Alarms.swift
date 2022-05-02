//
//  AlarmsList.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//

import Foundation

class Alarms: ObservableObject {
    @Published var list: [Alarm] = [
        Alarm(date: Date().addingTimeInterval(-3600), label: "Alarm", isActive: true, isSnooze: true),
        Alarm(date: Date(), label: "Alarm", isActive: true, isSnooze: false),
        Alarm(date: Date().addingTimeInterval(+3600), label: "Chuj",isActive: false, isSnooze: false)
        ]
}
