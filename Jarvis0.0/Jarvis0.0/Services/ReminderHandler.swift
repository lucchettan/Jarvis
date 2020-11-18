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
    func create(reminder: Reminder) -> String {
        let content = UNMutableNotificationContent()
        content.title = "You said so!"
        content.body = reminder.name
        content.badge = 0
        print("------this is the last path: -------")
        print(reminder.fileURL!.lastPathComponent)
        
        content.sound =  UNNotificationSound(named: UNNotificationSoundName(rawValue: reminder.fileURL!.lastPathComponent))
//                                                         .weekday
        var triggerTime = Calendar.current.dateComponents([.hour,.minute,.second,], from: reminder.time)
        triggerTime.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: true)
        
        let request = UNNotificationRequest(identifier: "\(reminder.id)", content: content, trigger: trigger)
        print(request.identifier)
        center.add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
            }
        }
        print("-----------notification created and assigned-------------")
        return request.identifier
    }
    
    func unable(reminder: Reminder){
        center.removePendingNotificationRequests(withIdentifiers: [reminder.notificationID!])
        print("---------Notification unabled----------")
    }
    
    
}
