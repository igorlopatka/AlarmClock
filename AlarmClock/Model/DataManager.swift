//
//  DataManager.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 09/05/2022.
//

import CoreData
import Foundation

class DataManager: ObservableObject {
    let container = NSPersistentContainer(name: "AlarmClock")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
