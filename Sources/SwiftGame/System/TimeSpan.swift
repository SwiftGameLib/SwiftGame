//
//  TimeSpan.swift
//  
//
//  Created by David Green on 10/23/20.
//

import Foundation

public let ticksPerMillisecond: Int64 = 10000
private let millisecondsPerTick: Double = 1.0 / Double(ticksPerMillisecond)

public let ticksPerSecond: Int64 = ticksPerMillisecond * 1000
private let secondsPerTick: Double = 1.0 / Double(ticksPerSecond)

public let ticksPerMinute: Int64 = ticksPerSecond * 60
private let minutesPerTick: Double = 1.0 / Double(ticksPerMinute)

public let ticksPerHour: Int64 = ticksPerMinute * 60
private let hoursPerTick: Double = 1.0 / Double(ticksPerHour)

public let ticksPerDay: Int64 = ticksPerHour * 24
private let daysPerTick: Double = 1.0 / Double(ticksPerDay)

private let millisPerSecond: Int = 1000
private let millisPerMinute: Int = millisPerSecond * 60
private let millisPerHour: Int = millisPerMinute * 60
private let millisPerDay: Int = millisPerHour * 24

internal let maxSeconds: Int64 = Int64.max / ticksPerSecond
internal let minSeconds: Int64 = Int64.min / ticksPerSecond

internal let maxMilliseconds: Int64 = Int64.max / ticksPerMillisecond
internal let minMilliseconds: Int64 = Int64.min / ticksPerMillisecond

internal let ticksPerTenthSecond: Int64 = ticksPerMillisecond * 100

public struct TimeSpan: Comparable, Equatable, Hashable {
    public static let zero: TimeSpan = TimeSpan()

    public static let maxValue: TimeSpan = TimeSpan(withTicks: Int64.max)
    public static let minValue: TimeSpan = TimeSpan(withTicks: Int64.min)

    // MARK: iVars
    internal var _ticks: Int64 = 0
    
    init() {}
    
    public init(withTicks ticks: Int64) {
        _ticks = ticks
    }
    
    public init(withHours hours: Int, minutes: Int, seconds: Int) {
        _ticks = timeToTicks(hour: hours, minute: minutes, second: seconds)
    }

    init(withDays days: Int, hours: Int, minutes: Int, seconds: Int) {
        self.init(withDays: days, hours: hours, minutes: minutes, seconds: seconds, milliseconds: 0)
    }
    
    public init(withDays days: Int, hours: Int, minutes: Int, seconds: Int, milliseconds: Int) {
        let daySeconds: Int64 = Int64(days) * 3600 * 24
        let hourSeconds: Int64 = Int64(hours) * 3600
        let minuteSeconds: Int64 = Int64(minutes) * 60
        let totalMilliseconds: Int64 = (daySeconds + hourSeconds + minuteSeconds + Int64(seconds)) * 1000 + Int64(milliseconds)
        if totalMilliseconds > maxMilliseconds || totalMilliseconds < minMilliseconds {
            fatalError("Overflow: TimeSpan too long") // TODO: switch to throwing?
        }
        _ticks = Int64(totalMilliseconds * ticksPerMillisecond)
    }

    // MARK: Properties
    public var ticks: Int64 {
        return _ticks
    }

    public var days: Int {
        return Int(_ticks / ticksPerDay)
    }

    public var hours: Int {
        return Int(_ticks / ticksPerHour) % 24
    }

    public var milliseconds: Int {
        return Int(_ticks / ticksPerMillisecond) % 1000
    }

    public var minutes: Int {
        return Int(_ticks / ticksPerMinute) % 60
    }

    public var seconds: Int {
        return Int(_ticks / ticksPerSecond) % 60
    }

    public var totalDays: Double {
        return Double(_ticks) * daysPerTick
    }

    public var totalHours: Double {
        return Double(_ticks) * hoursPerTick
    }

    public var totalMilliseconds: Double {
        var temp: Double = Double(_ticks) * millisecondsPerTick
        if temp > Double(maxMilliseconds) {
            temp = Double(maxMilliseconds)
        } else if temp < Double(minMilliseconds) {
            temp = Double(minMilliseconds)
        }

        return temp
    }

    public var totalMinutes: Double {
        return Double(_ticks) * minutesPerTick
    }

    public var totalSeconds: Double {
        return Double(_ticks) * secondsPerTick
    }
    
    // MARK: Methods
    public static func fromDays(days: Double) -> TimeSpan {
        return interval(days, millisPerDay)
    }

    public static func fromHours(hours: Double) -> TimeSpan {
        return interval(hours, millisPerHour)
    }

    public static func fromMilliseconds(milliseconds: Double) -> TimeSpan {
        return interval(milliseconds, 1)
    }

    public static func fromMinutes(minutes: Double) -> TimeSpan {
        return interval(minutes, millisPerMinute)
    }

    public static func fromSeconds(seconds: Double) -> TimeSpan {
        return interval(seconds, millisPerSecond)
    }

    public static func fromTicks(ticks: Int64) -> TimeSpan {
        return TimeSpan(withTicks: ticks)
    }

    private static func interval(_ value: Double, _ scale: Int) -> TimeSpan {
        let tmp = value * Double(scale)
        let millis = tmp * (value >= 0 ? 0.5: -0.5)
        return TimeSpan(withTicks: Int64(millis) * ticksPerMillisecond)
    }

    public func duration() -> TimeSpan {
        return TimeSpan(withTicks: abs(_ticks))
    }

    internal func timeToTicks(hour: Int, minute: Int, second: Int) -> Int64 {
        let totalSeconds = Int64(hour) * 3600 + Int64(minute) * 60 + Int64(second)
        return totalSeconds * ticksPerSecond
    }

    // MARK: Operators
    public static func + (left: TimeSpan, right: TimeSpan) -> TimeSpan {
        return TimeSpan(withTicks: left._ticks + right._ticks)
    }

    public static func - (left: TimeSpan, right: TimeSpan) -> TimeSpan {
        return TimeSpan(withTicks: left._ticks - right._ticks)
    }

    public static prefix func - (value: TimeSpan) -> TimeSpan {
        return TimeSpan(withTicks: -value._ticks)
    }
    
    // MARK: Comparable
    public static func < (lhs: TimeSpan, rhs: TimeSpan) -> Bool {
        return lhs._ticks < rhs._ticks
    }
}
