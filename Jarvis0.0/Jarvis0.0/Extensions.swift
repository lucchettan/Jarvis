//
//  Extensions.swift
//  Jarvis0.0
//
//  Created by Florent Frossard on 26/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import Foundation


extension Date {
    
    func toString( dateFormat format  : String ) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
