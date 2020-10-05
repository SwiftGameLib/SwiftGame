//
//  Vector2.swift
//  
//
//  Created by David Green on 10/5/20.
//

import Foundation

/// Describes a 2D vector

public struct Vector2: Equatable, Codable, CustomDebugStringConvertible {
    // MARK: - Static properties

    /// Returns a `Vector2` with components `0, 0`.
    public static let zero: Vector2 = Vector2(0, 0)

    /// Returns a `Vector2` with components `1, 1`.
    public static let one: Vector2 = Vector2(1, 1)

    /// Returns a `Vector2` with components `1, 0`.
    public static let unitX: Vector2 = Vector2(1, 0)

    /// Returns a `Vector2` with components `0, 1`.
    public static let unitY: Vector2 = Vector2(0, 1)

    // MARK: - Public ivars
    
    /// The *x* coordinate of this `Vector2`.
    public var x: Float
    /// The *y* coordinate of this `Vector2`.
    public var y: Float

    // MARK: - CustomDebugStringConvertible
    public var debugDescription: String {
        return "\(x) \(y)"
    }

    // MARK: - Constructors

    /// Constructs a 2d vector with X and Y from two values.
    ///
    /// - Parameters:
    ///   - x: The x coordinate in 2d space.
    ///   - y: The x coordinate in 2d space.

    public init(_ x: Float, _ y: Float) {
        self.x = x
        self.y = y
    }

    /// Constructs a 2D vector with X and Y set to the same value
    ///
    /// - Parameters:
    ///   - value: The x and y coordinates in 2d space.

    public init(_ value: Float) {
        x = value
        y = value
    }
}
