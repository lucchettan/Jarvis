//
//  CustomToggle.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct CustomToggle: View {
    @Binding var reminder: Reminder
    @State var reminders : [Reminder]
    var body: some View {
        HStack {
            if self.reminder.isOn { Spacer() }
            Circle()
                .fill(Color.white)
                .frame(width: 20, height: 20)
                .animation(.spring())
            if !self.reminder.isOn { Spacer() }
        }
        .onTapGesture {
            for i in 0..<self.reminders.count {
                if self.reminders[i] == self.reminder {
                    if self.reminder.isOn {
                        ReminderHandler().unable(reminder: self.reminder)
                    } else {
                        self.reminder.notificationID = ReminderHandler().create(reminder: self.reminder)
                        print(self.reminder)
                    }
                    self.reminder.isOn.toggle()
                    self.reminders[i] = self.reminder
                }
            }
            let defaults = UserDefaults.standard
            defaults.set(try? PropertyListEncoder().encode(self.reminders), forKey: "reminders")
            print(self.reminder)
        }
        .frame(width: 40, height: 20)
        .padding(5.0)
        .background(self.reminder.isOn ? Color.green : Color.red)
        .cornerRadius(50)
//------remove and append the notification to the notificationcenter depending on the toggle

    }
}
