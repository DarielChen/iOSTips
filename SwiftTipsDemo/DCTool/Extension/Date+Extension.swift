//
//  Date+Extension.swift
//  SwiftTipsDemo
//
//  Created by Dariel on 2019/7/26.
//  Copyright © 2019 Dariel. All rights reserved.
//

import Foundation

extension Date: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        if let date = TimeConverter.dateFrom(string: value) {
            self = date
        } else if let date = Date.dateFrom(string: value) {
            self = date
        } else {
            fatalError("invalid date string: '\(value)'")
        }
    }
    static func dateFrom(string: String) -> Date? {
        if let yearMonthDay = Date(fromString: string, format: "yyyy-MM-dd") {
            return yearMonthDay
        } else if let yearMonthDayHourMinute = Date(fromString: string, format: "yyyy-MM-dd HH:mm") {
            return yearMonthDayHourMinute
        } else if let yearMonthDayHourMinuteSecond = Date(fromString: string, format: "yyyy-MM-dd HH:mm:ss") {
            return yearMonthDayHourMinuteSecond
        } else {
            return nil
        }
    }
    public init?(fromString string: String, format: String,
                 timezone: TimeZone = TimeZone.autoupdatingCurrent, locale: Locale = Locale.current) {
        let formatter = DateFormatter()
        formatter.timeZone = timezone
        formatter.locale = locale
        formatter.dateFormat = format
        if let date = formatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
}

extension Date: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = TimeConverter.dateFrom(millisecondsSince1970: TimeInterval(value))
    }
}

public final class TimeConverter {
    static func stringFrom(date: Date) -> String {
        return millisecondsFrom(date: date).description
    }
    static func readableStringFrom(date: Date, dateStyle: DateFormatter.Style = .long) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        return formatter.string(from: date)
    }
    static func millisecondsFrom(date: Date) -> UInt64 {
        let seconds = date.timeIntervalSince1970
        let milliseconds = seconds * 1000
        return UInt64(milliseconds)
    }
    static func dateFrom(string: String) -> Date? {
        guard let millisecondsSince1970 = TimeInterval(string) else {
            return nil
        }
        return dateFrom(millisecondsSince1970: millisecondsSince1970)
    }
    static func dateFrom(millisecondsSince1970: TimeInterval) -> Date {
        if millisecondsSince1970 < 10000000000 {
            return Date(timeIntervalSince1970: millisecondsSince1970)
        } else {
            return Date(timeIntervalSince1970: millisecondsSince1970 / 1000)
        }
    }
}
