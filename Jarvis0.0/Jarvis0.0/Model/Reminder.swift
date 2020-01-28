//
//  Reminder.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import Foundation

struct Reminder: Codable, Hashable{
    var id = UUID()
    var name: String
//    var notification: UNNotificationRequest
    var time: Date
    var isOn: Bool
    
//----- Trial
    var fileURL: URL?
//    var createdAt: Date
}
