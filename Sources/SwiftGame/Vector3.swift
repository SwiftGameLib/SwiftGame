//
//  Vector3.swift
//  
//
//  Created by David Green on 10/5/20.
//

import Foundation

/// Describes a 3D vector

public struct Vector3: Equatable, Codable, CustomDebugStringConvertible {
    // MARK: - Static properties
    /// Returns a `Vector3` with components `0, 0, 0`.
    public static let zero: Vector3 = Vector3(0, 0, 0)

    /// Returns a `Vector3` with components `1, 1, 1`.
    public static let one: Vector3 = Vector3(1, 1, 1)

    /// Returns a `Vector3` with components `1, 0, 0`.
    public static let unitX: Vector3 = Vector3(1, 0, 0)

    /// Returns a `Vector3` with components `0, 1, 0`.
    public static let unitY: Vector3 = Vector3(0, 1, 0)

    /// Returns a `Vector3` with components `0, 0, 1`.
    public static let unitZ: Vector3 = Vector3(0, 0, 1)

    /// Returns a `Vector3` with components `0, 1, 0`.
    public static let up: Vector3 = Vector3(0, 1, 0)

    /// Returns a `Vector3` with components `0, -1, 0`.
    public static let down: Vector3 = Vector3(0, -1, 0)

    /// Returns a `Vector3` with components `0, -1, 0`.
    public static let right: Vector3 = Vector3(0, -1, 0)

    /// Returns a `Vector3` with components `-1, 0, 0`.
    public static let left: Vector3 = Vector3(-1, 0, 0)

    /// Returns a `Vector3` with components `0, 0, -1`.
    public static let forward: Vector3 = Vector3(0, 0, -1)

    /// Returns a `Vector3` with components `0, 0, 1`.
    public static let backward: Vector3 = Vector3(0, 0, 1)

    // MARK: - Public ivars
    /// The *x* coordinate of this `Vector3`.
    public var x: Float
    /// The *y* coordinate of this `Vector3`.
    public var y: Float
    /// The *z* coordinate of this `Vector3`.
    public var z: Float

    // MARK: - CustomDebugStringConvertible
    public var debugDescription: String {
        return "\(x) \(y) \(z)"
    }

    // MARK: - Constructors

    /// Constructs a 3d vector with X, Y, and Z from three values.
    ///
    /// - Parameters:
    ///   - x: The x coordinate in 3d space.
    ///   - y: The y coordinate in 3d space.
    ///   - z: The z coordinate in 3d space.

    public init(_ x: Float, _ y: Float, _ z: Float) {
        self.x = x
        self.y = y
        self.z = z
    }

    /// Constructs a 3D vector with X, Y, and Z set to the same value
    ///
    /// - Parameters:
    ///   - value: The x, y, and z coordinates in 3d space.

    public init(_ value: Float) {
        x = value
        y = value
        z = value
    }

    /// Constructs a 3D vector with X, Y from a `Vector2` and Z from a scalar.
    ///
    /// - Parameters:
    ///   - value: The x and y coordinates in 3d space.
    ///   - z: The z coordinate in 3d space.

    public init(_ value: Vector2, z: Float) {
        x = value.x
        y = value.y
        self.z = z
    }
}
