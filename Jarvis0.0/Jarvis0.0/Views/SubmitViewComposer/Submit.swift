//
//  TimeIndicatorView.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 30/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct Submit: View {
//--This will allow us to make the Sheet disappear and go back to contentView
    @Binding var isModal: Bool
//--Array in the wich we are going to add our created Memo
    @Binding var reminders: [Reminder]
//--Generate value that we will assign to validate the new reminder
    @State var date = Date()
//--Creating an empty reminder
    @State var newReminder = Reminder(name: "Listen", time: Date(), isOn: true)

    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Text("Set the clock")
                        .font(.headline)
                        .offset(y: -90)
                    Rectangle()
                        .frame(width: 250, height: 150)
                        .cornerRadius(15)
                        .overlay(
                             RoundedRectangle(cornerRadius: 20)
                                 .stroke(Color.orange, lineWidth: 1)
                         )
                        .foregroundColor(Color.clear)
                    DatePicker(selection: $date, displayedComponents: .hourAndMinute){
                        Text("")
                    }
                    .frame(width: 250)
                    .mask(HStack{
                        Spacer()
                        Rectangle()
                            .frame(width: 230, height: 140)
                            .cornerRadius(15)
                            .offset(y: 40)
                        Spacer()
                        }
                    )
                }
                    .padding(EdgeInsets(top: 150, leading: 0, bottom: 150, trailing: 0))
                Text("Record yourself")
                    .font(.headline)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: -10, trailing: 0))
                AnimatedButton(reminder: $newReminder)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 0))
            }
            .frame(height: 500)
            .navigationBarTitle("New vocal reminder")
            .navigationBarItems(leading:
                Button("Cancel") {
                    self.isModal.toggle()
                    print("About tapped!")
                }.foregroundColor(.orange)
                , trailing:
                Button("Save") {
                //Set the new Reminder
                self.newReminder.time = self.date
                //Creating the notification and assigning the requestID to the notificationID value of the reminder
                self.newReminder.notificationID = ReminderHandler().create(reminder: self.newReminder)
                self.reminders.append(self.newReminder)
                self.isModal.toggle()
                let defaults = UserDefaults.standard
                defaults.set(try? PropertyListEncoder().encode(self.reminders), forKey: "reminders")
            }
                .foregroundColor(self.newReminder.fileURL == nil ? .gray : .orange)
                .disabled(self.newReminder.fileURL == nil ? true : false))
        }
    }
}
