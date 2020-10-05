//
//  Vector4.swift
//  
//
//  Created by David Green on 10/5/20.
//

import Foundation

/// Describes a 4D vector

public struct Vector4: Equatable, Codable, CustomDebugStringConvertible {
    // MARK: - Static properties
    /// Returns a `Vector4` with components `0, 0, 0, 0`.
    public static let zero: Vector4 = Vector4(0, 0, 0, 0)

    /// Returns a `Vector4` with components `1, 1, 1, 1`.
    public static let one: Vector4 = Vector4(1, 1, 1, 1)

    /// Returns a `Vector4` with components `1, 0, 0, 0`.
    public static let unitX: Vector4 = Vector4(1, 0, 0, 0)

    /// Returns a `Vector4` with components `0, 1, 0, 0`.
    public static let unitY: Vector4 = Vector4(0, 1, 0, 0)

    /// Returns a `Vector4` with components `0, 0, 1, 0`.
    public static let unitZ: Vector4 = Vector4(0, 0, 1, 0)

    /// Returns a `Vector4` with components `0, 0, 0, 1`.
    public static let unitW: Vector4 = Vector4(0, 0, 0, 1)



    // MARK: - Public ivars
    /// The *x* coordinate of this `Vector4`.
    public var x: Float

    /// The *y* coordinate of this `Vector4`.
    public var y: Float

    /// The *z* coordinate of this `Vector4`.
    public var z: Float

    /// The *w* coordinate of this `Vector4`.
    public var w: Float

    // MARK: - CustomDebugStringConvertible
    public var debugDescription: String {
        return "\(x) \(y) \(z) \(w)"
    }

    // MARK: - Constructors

    /// Constructs a 4d vector with X, Y, Z, and W from four values.
    ///
    /// - Parameters:
    ///   - x: The x coordinate in 4d space.
    ///   - y: The y coordinate in 4d space.
    ///   - z: The z coordinate in 4d space.
    ///   - w: The w coordinate in 4d space.

    public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    /// Constructs a 4D vector with X, Y from a `Vector2` and Z and W from scalars.
    ///
    /// - Parameters:
    ///   - value: The x and y coordinates in 4d space.
    ///   - z: The z coordinate in 4d space.
    ///   - w: The w coordinate in 4d space.

    public init(_ value: Vector2, z: Float, w: Float) {
        x = value.x
        y = value.y
        self.z = z
        self.w = w
    }

    /// Constructs a 4D vector with X, Y, Z from a `Vector2` and W from a scalar.
    ///
    /// - Parameters:
    ///   - value: The x, y and z coordinates in 4d space.
    ///   - w: The w coordinate in 4d space.

    public init(_ value: Vector3, w: Float) {
        x = value.x
        y = value.y
        z = value.z
        self.w = w
    }

    /// Constructs a 4D vector with X, Y, Z, and W set to the same value
    ///
    /// - Parameters:
    ///   - value: The x, y, z, and 3 coordinates in 4d space.

    public init(_ value: Float) {
        x = value
        y = value
        z = value
        w = value
    }
}
