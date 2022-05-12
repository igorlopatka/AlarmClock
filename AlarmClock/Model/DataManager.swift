//
//  DataManager.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 09/05/2022.
//

import CoreData
import Foundation

class DataManager: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var alarms: [Alarm] = []
    
    init() {
        container = NSPersistentContainer(name: "AlarmClock")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error loading persistent stores: \(error.localizedDescription)")
            }
        }
        getAlarms()
    }
    
    func getAlarms() {
        let request = NSFetchRequest<Alarm>(entityName: "Alarm")
        do {
            try alarms = container.viewContext.fetch(request)
        } catch {
            print("Error getting data: \(error.localizedDescription)")
        }
    }
    
    func addAlarm(label: String, date: Date) {
        let newAlarm = Alarm(context: container.viewContext)
        newAlarm.label = label
        newAlarm.date = date
        newAlarm.id = UUID()
        newAlarm.isActive = false
        saveData()
    }
    
    func deleteAlarm(offsets: IndexSet) {
        offsets.map {alarms[$0]}.forEach(container.viewContext.delete)
        do {
            saveData()
        }
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            getAlarms()
        } catch let error {
            print("Error: \(error)")
        }
    }
}
