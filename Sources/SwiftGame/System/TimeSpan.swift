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

public struct TimeSpan: Comparable, Equatable {
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
    
    // MARK: Methods
    internal func timeToTicks(hour: Int, minute: Int, second: Int) -> Int64 {
        let totalSeconds = Int64(hour) * 3600 + Int64(minute) * 60 + Int64(second)
        if totalSeconds > maxSeconds || totalSeconds < minSeconds {
            fatalError("Overflow: TimeSpan too long")
        }
        return totalSeconds * ticksPerSecond
    }
    
    // MARK: Comparable
    public static func < (lhs: TimeSpan, rhs: TimeSpan) -> Bool {
        return lhs._ticks < rhs._ticks
    }
}
