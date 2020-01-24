//
//  Reminder.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import Foundation


struct Reminder: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var time: Date
    var isOn: Bool
}
