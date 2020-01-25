//
//  ReminderCellView.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct ReminderCellView: View {
    
    @State var reminder: Reminder
    var body: some View {
        HStack {
            VStack(alignment: .center){
                Text(getHourFromDate(date: self.reminder.time))
                    .font(.system(size: 40))
                Text(self.reminder.name)

            }
            Spacer()
            CustomToggle(isOn: self.$reminder.isOn)
        }
    }
    
    func getHourFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat  = "HH:mm"
        return formatter.string(from: date)
    }
}
