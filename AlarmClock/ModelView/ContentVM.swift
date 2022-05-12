//
//  ContentVM.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 12/05/2022.
//

import Foundation
import CoreData

class ContentVM: ObservableObject {
    
    @Published var notification = NotificationManager()
    
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
}
