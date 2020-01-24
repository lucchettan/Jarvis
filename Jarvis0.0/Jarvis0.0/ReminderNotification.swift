//
//  ReminderNotification.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 08/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderNotificationViewController: UIViewController {

    func createNotification (reminder: Reminder){
        let content = UNMutableNotificationContent()
        content.title = "Don't forget to:"
        content.body = reminder.name
        content.badge = 1
        
        let gregorian = Calendar(identifier: .gregorian)
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: reminder.time)


        let date = gregorian.date(from: components)!

        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: reminder.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
    }
}
