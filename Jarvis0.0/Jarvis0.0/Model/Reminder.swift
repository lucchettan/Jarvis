//
//  Reminder.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import Foundation
import UserNotifications


struct Reminder: Codable, Hashable{
    var id = UUID()
    var name: String
    var time: Date
    var isOn: Bool
//  var weekdayRecurrence : []
    
    var fileURL: URL?
    var notificationID: String?
}
