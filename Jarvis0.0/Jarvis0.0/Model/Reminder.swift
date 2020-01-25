//
//  Reminder.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class Reminder: NSCoder, NSCoding {
//    var id: Int
    var name: String
//    var notification: UILocalNotification
    var time: Date
    var isOn: Bool
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("reminders")
    
    // enum for property types
    struct PropertyKey {
        static let nameKey = "name"
//        static let notificationKey = "notification"
        static let timeKey = "time"
        static let isOnKey = "isOn"
    }
    
    init(name: String, time: Date, isOn: Bool) {
//            self.id = id
            self.name = name
//            self.notification = notification
            self.time = time
            self.isOn = isOn
        }

        required convenience init(coder aDecoder: NSCoder) {
//            let id = aDecoder.decodeInteger(forKey: "id")
            let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
//            let notification = aDecoder.decodeObject(forKey: PropertyKey.notificationKey) as! UILocalNotification
            let time = aDecoder.decodeObject(forKey: PropertyKey.timeKey) as! Date
            let isOn = aDecoder.decodeObject(forKey: PropertyKey.isOnKey) as! Bool
            
            self.init(name: name, time: time, isOn: isOn)
        }

        func encode(with aCoder: NSCoder) {
//            aCoder.encode(id, forKey: "id")
            aCoder.encode(name, forKey: PropertyKey.nameKey)
//            aCoder.encode(notification, forKey: PropertyKey.notificationKey)
            aCoder.encode(time, forKey: PropertyKey.timeKey)
            aCoder.encode(isOn, forKey: PropertyKey.isOnKey)
        }


}
