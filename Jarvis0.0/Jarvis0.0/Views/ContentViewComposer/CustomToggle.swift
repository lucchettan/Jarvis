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
    var body: some View {
        HStack {
            if !self.reminder.isOn { Spacer() }
            Circle()
                .fill(Color.white)
                .frame(width: 20, height: 20)
                .animation(.spring())
            if self.reminder.isOn { Spacer() }
        }
        .frame(width: 40, height: 20)
        .padding(5.0)
        .background(self.reminder.isOn ? Color.green : Color.red)
        .animation(.easeInOut)
        .cornerRadius(50)
//------remove and append the notification to the notificationcenter depending on the toggle
        .onTapGesture {
            self.reminder.isOn.toggle()
            if self.reminder.isOn {
                ReminderHandler().unable(reminder: self.reminder)
            } else {
                self.reminder.notificationID = ReminderHandler().create(reminder: self.reminder)
                print("------toggle step 1 creating ------")
                print(self.reminder)
            }
            print("-----finish toggling-----")
            print(self.reminder)
        }
    }
}
