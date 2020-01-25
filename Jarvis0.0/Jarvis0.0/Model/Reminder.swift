//
//  Reminder.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import Foundation
import UserNotifications

class Reminder: NSCoder, NSCoding, UNUserNotificationCenterDelegate{
//    var id: Int
    var name: String
//    var notification: UILocalNotification
    var time: Date
    var isOn: Bool
    
    init(name: String, time: Date, isOn: Bool) {
//            self.id = id
            self.name = name
//            self.notification = notification
            self.time = time
            self.isOn = isOn
        }

        required convenience init(coder aDecoder: NSCoder) {
//            let id = aDecoder.decodeInteger(forKey: "id")
            let name = aDecoder.decodeObject(forKey: "name") as! String
//            let notification = aDecoder.decodeObject(forKey: "notification") as! UILocalNotification
            let time = aDecoder.decodeObject(forKey: "time") as! Date
            let isOn = aDecoder.decodeObject(forKey: "isOn") as! Bool
            self.init(name: name, time: time, isOn: isOn)
        }

        func encode(with aCoder: NSCoder) {
//            aCoder.encode(id, forKey: "id")
            aCoder.encode(name, forKey: "notification")
            aCoder.encode(time, forKey: "time")
            aCoder.encode(isOn, forKey: "isOn")
        }


}
