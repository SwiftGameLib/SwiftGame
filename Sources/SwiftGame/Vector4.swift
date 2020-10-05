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

// MARK: - Operators

public extension Vector4 {

    /// Inverts the values in the `Vector4`.
    ///
    /// - Parameters:
    ///   - vector: Source `Vector4` on the right of the negative sign.
    ///
    /// - Returns:Result of the inversion.

    @inlinable
    static prefix func - (vector: Vector4) -> Vector4 {
        return Vector4(-vector.x, -vector.y, -vector.z, -vector.w)
    }

    /// Adds two vectors.
    ///
    /// - Parameters:
    ///   - left: Source `Vector4` on the left of the plus sign.
    ///   - right: Source `Vector4` on the right of the plus] sign.
    ///
    /// - Returns:Sum of the vectors.

    @inlinable
    static func + (left: Vector4, right: Vector4) -> Vector4 {
        return Vector4(left.x + right.x, left.y + right.y, left.z + right.z, left.w + right.w)
    }

    /// Subtracts a `Vector4` from a `Vector4`.
    ///
    /// - Parameters:
    ///   - left: Source `Vector4` on the left of the minus sign.
    ///   - right: Source `Vector4` on the right of the minus sign.
    ///
    /// - Returns:Result of the vector subtraction.

    @inlinable
    static func - (left: Vector4, right: Vector4) -> Vector4 {
        return Vector4(left.x - right.x, left.y - right.y, left.z - right.z, left.w - right.w)
    }

    /// Multiplies the components of two `Vector4`s by each other.
    ///
    /// - Parameters:
    ///   - left: Source `Vector4` on the left of the multiplication sign.
    ///   - right: Source `Vector4` on the right of the multiplication sign.
    ///
    /// - Returns:Result of the vector multiplication.

    @inlinable
    static func * (left: Vector4, right: Vector4) -> Vector4 {
        return Vector4(left.x * right.x, left.y * right.y, left.z * right.z, left.w * right.w)
    }

    /// Multiplies the components of a`Vector4` by a scalar.
    ///
    /// - Parameters:
    ///   - left: Source `Vector4` on the left of the multiplication sign.
    ///   - right: Scalar value on the right of the multiplication sign.
    ///
    /// - Returns:Result of the vector multiplication by a scalar.

    @inlinable
    static func * (left: Vector4, right: Float) -> Vector4 {
        return Vector4(left.x * right, left.y * right, left.z * right, left.w * right)
    }

    /// Multiplies the components of a`Vector4` by a scalar.
    ///
    /// - Parameters:
    ///   - left: Scalar value on the left of the multiplication sign.
    ///   - right: Source `Vector4` on the right of the multiplication sign.
    ///
    /// - Returns:Result of the vector multiplication by a scalar.

    @inlinable
    static func * (left: Float, right: Vector4) -> Vector4 {
        return Vector4(left * right.x, left * right.y, left * right.z, left * right.w)
    }

    /// Divides the components of two `Vector4`s by each other.
    ///
    /// - Parameters:
    ///   - left: Source `Vector4` on the left of the division sign.
    ///   - right: Source `Vector4` on the right of the division sign.
    ///
    /// - Returns:Result of the vector division.

    @inlinable
    @inline(__always)
    static func / (left: Vector4, right: Vector4) -> Vector4 {
        return Vector4(left.x / right.x, left.y / right.y, left.z / right.z, left.w / right.w)
    }

    /// Divides the components of a`Vector4` by a scalar.
    ///
    /// - Parameters:
    ///   - left: Source `Vector4` on the left of the division sign.
    ///   - right: Scalar value on the right of the division sign.
    ///
    /// - Returns:Result of the vector division by a scalar.

    @inlinable
    @inline(__always)
    static func / (left: Vector4, right: Float) -> Vector4 {
        let factor = 1.0 / right
        return Vector4(left.x * factor, left.y * factor, left.z * factor, left.w * factor)
    }
}
