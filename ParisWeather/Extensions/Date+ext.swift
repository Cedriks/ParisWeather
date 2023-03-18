//
//  Date+ext.swift
//  ParisWeather
//
//  Created by Cedrik on 18/03/2023.
//

import Foundation

extension Date {
    
    func makeReadableDate(dt: Int) -> Date {
        Date(timeIntervalSince1970: TimeInterval(dt))
    }
    
    func toString(format: String = "dd-MM-yyyy HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getHumanReadableDayString() -> String {
            let weekdays = [
                "Sunday",
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday"
            ]
            
            let calendar = Calendar.current.component(.weekday, from: self)
            return weekdays[calendar - 1]
        }
}
