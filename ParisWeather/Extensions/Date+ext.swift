//
//  Date+ext.swift
//  ParisWeather
//
//  Created by Cedrik on 20/03/2023.
//

import Foundation

extension Date {
    
    static func makeReadableDate(dt: Int) -> Date {
        Date(timeIntervalSince1970: TimeInterval(dt))
    }
    
    func toString(format: String = "dd-MM-yyyy HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toStringHours(format: String = "HH:mm") -> String {
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
    
    func getHumanReadableMonthString() -> String {
        let months = [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        ]
        let calendar = Calendar.current.component(.month, from: self)
        return months[calendar - 1]
    }
    
    func lastDate() -> Date {
        let nextDate = Calendar.current.date(byAdding: .day, value: 5, to: self)
        return nextDate ?? Date()
    }
    func nextDate() -> Date {
        let nextDate =  Calendar.current.date(byAdding: .day, value: 1, to: self)
        return nextDate ?? Date()
    }
}
