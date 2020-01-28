//
//  SubmitView.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 19/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct SubmitView: View {
//--This will allow us to make the Sheet disappear and go back to contentView
    @Binding var isModal: Bool
//--Array in the wich we are going to add our created Memo
    @Binding var reminders: [Reminder]
//--Generate value that we will assign to validate the new reminder
    @State var timePicked = Date()
    @State var title = ""
//--Creating an empty reminder
    @State var newReminder = Reminder(name: "trial", time: Date(), isOn: true)
    

    var body: some View {
        VStack {
            VStack {
                DatePicker(selection: $timePicked, displayedComponents: .hourAndMinute) {
                    Text("Heure du rappel")
                }
                CustomToggle(isOn: self.$newReminder.isOn)
                AnimatedButton(reminder: $newReminder)
            }
            Button (action: {
//                    guard self.title != "" else {return}
//------------------Create a new Reminder
                self.newReminder.name = self.title
                self.newReminder.time = self.timePicked
                self.reminders.append(self.newReminder)
//------------------now we make de page disappear
                self.isModal = false
//------------------creating the notification
                ReminderHandler().create(reminder: self.newReminder)
                let defaults = UserDefaults.standard
                defaults.set(try? PropertyListEncoder().encode(self.reminders), forKey: "reminders")
            }){
                Text("Save")
            }
        }
    }
}
