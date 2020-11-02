//
//  modalDateSelection.swift
//  Jarvis0.0
//
//  Created by mac on 27/10/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct DateSelectionModal: View {
    
    @Binding var showModal: Bool
    @State var date = Date()
    @Binding var reminders: [Reminder]
    @Binding var newReminder : Reminder
    
    var body: some View {
        ZStack{
            Blur()
                .edgesIgnoringSafeArea(.vertical)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    self.newReminder = Reminder(name: "Empty Reminder to work with", time: Date(), isOn: true)
                    //Dismiss the modal
                    showModal.toggle()
                }
            
            VStack(alignment: .center) {
                Text("Select the moment")
                    .font(.caption)
                    .foregroundColor(.primary)
                HStack {
                    Image(systemName: "calendar.circle.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                    if #available(iOS 14.0, *) {
                        DatePicker(selection: $date, displayedComponents: .hourAndMinute){
                            Text("")
                        }
                    } else {// To hide show only few lines of the picker in iOS 13 or lower
                        DatePicker(selection: $date, displayedComponents: .hourAndMinute){
                            Text("")
                        }
                        .frame(width: 150)
                        .mask(
                            HStack{
                                Spacer()
                                Rectangle()
                                    .frame(width: 130, height: 120)
                                    .cornerRadius(15)
                                    .offset(y: 55)
                                Spacer()
                            }
                        )
                    }
                }
                Spacer()
                Button(action: {
                    //Set the new Reminder's date
                    self.newReminder.time = self.date
                    //Creating the notification and assigning the requestID to the notificationID value of the reminder
                    self.newReminder.notificationID = ReminderHandler().create(reminder: self.newReminder)
                    self.reminders.append(self.newReminder)
                    let defaults = UserDefaults.standard
                    defaults.set(try? PropertyListEncoder().encode(self.reminders), forKey: "reminders")
                    //Reset the empty reminder of the ContentView
                    self.newReminder = Reminder(name: "Empty Reminder to work with", time: Date(), isOn: true)
                    //Dismiss the modal
                    showModal.toggle()
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(width: 170, height: 30)
                        .background(self.newReminder.fileURL == nil ? Color.gray : Color.pink)
                        .cornerRadius(10)
                }
//                .disabled(self.newReminder.fileURL == nil ? true : false)
            }
            .padding()
            .background(Color.white.cornerRadius(20).shadow(radius: 10))
            .frame(width: 200, height: 150)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5))
        }
    }
}

