//
//  Date+Calendar.swift
//  Asteroids
//
//  Created by bu on 23/06/2017.
//  Copyright © 2017 olegshamin. All rights reserved.
//

import Foundation

extension Date {
    func dateFromDays(_ days: Int) -> Date {
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: days, to: self, options: [])!
    }
}
