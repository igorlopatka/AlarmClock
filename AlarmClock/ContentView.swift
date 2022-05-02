//
//  ContentView.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var alarms: [Alarm] = [
        Alarm(date: Date().addingTimeInterval(-3600), label: "Alarm", isActive: true, isSnooze: true),
        Alarm(date: Date(), label: "Alarm", isActive: true, isSnooze: false),
        Alarm(date: Date().addingTimeInterval(+3600), label: "Alarm",isActive: false, isSnooze: false)
        ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(alarms.indices, id: \.self) { index in
                    HStack {
                        VStack {
                            Text(self.alarms[index].date, formatter: timeFormat)
                                .font(.largeTitle)
                            Text(self.alarms[index].label)
                        }
                        Toggle("", isOn: self.$alarms[index].isActive)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationBarTitle("AlarmClock")
        }
    }
    
    let timeFormat: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "h:mm"
      return formatter
    }()
    
    func delete(at offsets: IndexSet) {
            alarms.remove(atOffsets: offsets)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
