//
//  ReminderHandler.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 25/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import Foundation
import AVFoundation
import UserNotifications
 
class ReminderHandler {
    let center = UNUserNotificationCenter.current()
    
        func create(reminder: Reminder) {
            let content = UNMutableNotificationContent()
            content.title = "Don't forget to:"
            content.body = reminder.name
            content.badge = 1
//            content.sound = UNNotificationSound(coder: Reader().stringReader(string: reminder.name))
            content.sound = .default
    //--------------what izit
            content.userInfo = ["value": "Data with local notification"]
            
            let gregorian = Calendar(identifier: .gregorian)
            var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: reminder.time)
            let date = gregorian.date(from: components)!
            let triggerTime = Calendar.current.dateComponents([.hour,.minute,.second,], from: reminder.time)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: true)

            
            let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: trigger)
            
            
            center.add(request) { (error) in
                if error != nil {
                    print("Error = \(error?.localizedDescription ?? "error local notification")")
                }
                
                print(date)
                print(request)
                print("added to center")
            }
        }
}
