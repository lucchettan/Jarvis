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
    @State var title = ""
    @State var date = Date()
//--Creating an empty reminder
    @State var newReminder = Reminder(name: "trial", time: Date(), isOn: true)

    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Rectangle()
                        .frame(width: 250, height: 150)
                        .cornerRadius(15)
                        .overlay(
                             RoundedRectangle(cornerRadius: 20)
                                 .stroke(Color.orange, lineWidth: 3)
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
                
                AnimatedButton(reminder: $newReminder)
            }
            .frame(height: 500)
            .navigationBarTitle("New vocal reminder:")
            .navigationBarItems(leading:
                Button("Cancel") {
                    self.isModal = false
                    print("About tapped!")
                }.foregroundColor(.orange)
                , trailing:
                Button("Save") {
                //  set the new Reminder
                self.newReminder.name = self.title
                self.newReminder.time = self.date
                self.reminders.append(self.newReminder)
                //  Make the page disappear
                self.isModal = false
                //  Creating the notification
                ReminderHandler().create(reminder: self.newReminder)
                let defaults = UserDefaults.standard
                defaults.set(try? PropertyListEncoder().encode(self.reminders), forKey: "reminders")
            }
                .foregroundColor(self.newReminder.fileURL == nil ? .gray : .orange)
                .disabled(self.newReminder.fileURL == nil ? true : false))
        }
    }
}
