//
//  SubmitView.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 19/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct SubmitView: View {
//-----This will allow us to make the Sheet disappear from the screen
    @Binding var isModal: Bool
//---Array in the wich we are going to add our created Memo
    @Binding var reminders: [Reminder]
//----Generate value that we will assign to validate the new Memo
    @State var timePicked = Date()
    @State var title = ""
    @State var isOn = true
    
    enum UserDefaultsKeys: String {
        case reminder
    }
    

    var body: some View {
        VStack {
                    Form {
                        Section (header: Text("Nouveau Memo")) {
                            TextField("Nom de l'exercice", text: $title)
                                .lineLimit(4)
                                .multilineTextAlignment(.leading)
                                .frame(height: 100)
                            Toggle(isOn: $isOn){
                                Text(self.isOn ? "Activé" : "Désactivé")
                            }
                            DatePicker(selection: $timePicked, displayedComponents: .hourAndMinute) {
                                Text("Heure du rappel")
                            }
                        }
                        Section (header: Text("Validation")) {
                            Button (action: {
                                guard self.title != "" else {return}
                                let newReminder = Reminder(name: self.title, time: self.timePicked, isOn: self.isOn)
                                self.reminders.append(newReminder)
//                        now we make de page disappear
                                self.isModal = false
//                                ----------create the notification
                                ReminderHandler().create(reminder: newReminder)
                                let defaults = UserDefaults.standard
                                defaults.set(try? PropertyListEncoder().encode(self.reminders), forKey: "reminders")

                            }) {
                                Text("Valider")
                            }
                        }
                    }
                    Spacer()
                }
    }
    
//    public func simpleAddNotification(hour: Int, minute: Int, identifier: String, title: String, body: String) {
//        // Initialize User Notification Center Object
//        let center = UNUserNotificationCenter.current()
//
//        // The content of the Notification
//        let content = UNMutableNotificationContent()
//        content.title = title
//        content.body = body
//        content.sound = .default
//
//        // The selected time to notify the user
//        var dateComponents = DateComponents()
//        dateComponents.calendar = Calendar.current
//        dateComponents.hour = hour
//        dateComponents.minute = minute
//
//        // The time/repeat trigger
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        // Initializing the Notification Request object to add to the Notification Center
//        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//
//        // Adding the notification to the center
//        center.add(request) { (error) in
//            if (error) != nil {
//                print(error!.localizedDescription)
//            }
//        }
//    }
}
