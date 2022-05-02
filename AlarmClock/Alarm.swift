//
//  Alarm.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//

import Foundation

struct Alarm: Identifiable, Hashable {
    
    let id: UUID
    var date: Date
    var label: String
    var isActive: Bool
    var isSnooze: Bool
    
    
    init(date: Date, label: String, isActive: Bool, isSnooze: Bool) {
        self.id = UUID()
        self.date = date
        self.label = label
        self.isActive = isActive
        self.isSnooze = isSnooze
    }
}
