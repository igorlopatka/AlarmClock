//
//  ContentView.swift
//  AlarmClock
//
//  Created by Igor Łopatka on 02/05/2022.
//

import SwiftUI

struct ContentView: View {
        
    @StateObject var alarms = Alarms()
    
    @State private var isAddingAlarm = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(alarms.list.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(self.alarms.list[index].date, formatter: timeFormat)
                                .font(.largeTitle)
                            Text(self.alarms.list[index].label)
                        }
                        Toggle("", isOn: self.$alarms.list[index].isActive)
                    }
                }
                .onDelete(perform: delete)
            }
            .sheet(isPresented: $isAddingAlarm) {
                AddAlarmView(alarms: alarms)
            }
            .navigationBarTitle("AlarmClock")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        isAddingAlarm.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    let timeFormat: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "h:mm"
      return formatter
    }()
    
    func delete(at offsets: IndexSet) {
        alarms.list.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
