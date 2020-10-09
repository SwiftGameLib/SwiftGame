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

// MARK: - Public methods

public extension Vector2 {

    /// Creates a new `Vector2` that contains the cartesian coordinates of a vector specified in barycentric coordinates and relative to a 2d triangle.
    /// - Parameters:
    ///   - value1: The first vector of a 2d triangle.
    ///   - value2: The second vector of a 2d triangle.
    ///   - value3: The third vector of a 2d triangle.
    ///   - amount1: Barycentric scalar **b2** which represents a weighting factor towards the second vector of the 2d triangle.
    ///   - amount2: Barycentric scalar **b3** which represents a weighting factor towards the third vector of the 2d triangle.
    /// - Returns: The cartesian translation of barycentric coordinates.
    static func barycentric(_ value1: Vector2, _ value2: Vector2, _ value3: Vector2, amount1: Float, amount2: Float) -> Vector2 {
        return Vector2(
            MathHelper.barycentric(value1.x, value2.x, value3.x, amount1: amount1, amount2: amount2),
            MathHelper.barycentric(value1.y, value2.y, value3.y, amount1: amount1, amount2: amount2))
    }

    /// Creates a new `Vector2` that contains the cartesian coordinates of a vector specified in barycentric coordinates and relative to a 2d triangle.
    /// - Parameters:
    ///   - value1: The first vector of a 2d triangle.
    ///   - value2: The second vector of a 2d triangle.
    ///   - value3: The third vector of a 2d triangle.
    ///   - amount1: Barycentric scalar **b2** which represents a weighting factor towards the second vector of the 2d triangle.
    ///   - amount2: Barycentric scalar **b3** which represents a weighting factor towards the third vector of the 2d triangle.
    ///   - result: The cartesian translation of barycentric coordinates as an `inout` parameter.
    static func barycentric(_ value1: Vector2, _ value2: Vector2, _ value3: Vector2, amount1: Float, amount2: Float, result: inout Vector2) {
        result.x = MathHelper.barycentric(value1.x, value2.x, value3.x, amount1: amount1, amount2: amount2)
        result.y = MathHelper.barycentric(value1.y, value2.y, value3.y, amount1: amount1, amount2: amount2)
    }

    /// Creates a new `Vector2` that contains the Catmull Rom interpolation of the specified vectors.
    /// - Parameters:
    ///   - value1: The first vector in the interpolation.
    ///   - value2: The second vector in the interpolation.
    ///   - value3: The third vector in the interpolation.
    ///   - value4: The fourth vector in the interpolation.
    ///   - amount: Weighting factor.
    /// - Returns: The result of the interpolation.
    static func catmullRom(_ value1: Vector2, _ value2: Vector2, _ value3: Vector2, _ value4: Vector2, amount: Float) -> Vector2 {
        return Vector2(
            MathHelper.catmullRom(value1.x, value2.x, value3.x, value4.x, amount: amount),
            MathHelper.catmullRom(value1.y, value2.y, value3.y, value4.y, amount: amount))
    }

    /// Creates a new `Vector2` that contains the Catmull Rom interpolation of the specified vectors.
    /// - Parameters:
    ///   - value1: The first vector in the interpolation.
    ///   - value2: The second vector in the interpolation.
    ///   - value3: The third vector in the interpolation.
    ///   - value4: The fourth vector in the interpolation.
    ///   - amount: Weighting factor.
    ///   - result: The result of the interpolation as an `inout` parameter..
    static func catmullRom(_ value1: Vector2, _ value2: Vector2, _ value3: Vector2, _ value4: Vector2, amount: Float, result: inout Vector2) {
        result.x = MathHelper.catmullRom(value1.x, value2.x, value3.x, value4.x, amount: amount)
        result.y = MathHelper.catmullRom(value1.y, value2.y, value3.y, value4.y, amount: amount)
    }
}

// MARK: - Operators

public extension Vector2 {

    /// Inverts the values in the `Vector2`.
    ///
    /// - Parameters:
    ///   - vector: Source `Vector2` on the right of the negative sign.
    ///
    /// - Returns:Result of the inversion.

    @inlinable
    static prefix func - (vector: Vector2) -> Vector2 {
        return Vector2(-vector.x, -vector.y)
    }

    /// Adds two vectors.
    ///
    /// - Parameters:
    ///   - left: Source `Vector2` on the left of the plus sign.
    ///   - right: Source `Vector2` on the right of the plus] sign.
    ///
    /// - Returns:Sum of the vectors.

    @inlinable
    static func + (left: Vector2, right: Vector2) -> Vector2 {
        return Vector2(left.x + right.x, left.y + right.y)
    }

    /// Subtracts a `Vector2` from a `Vector2`.
    ///
    /// - Parameters:
    ///   - left: Source `Vector2` on the left of the minus sign.
    ///   - right: Source `Vector2` on the right of the minus sign.
    ///
    /// - Returns:Result of the vector subtraction.

    @inlinable
    static func - (left: Vector2, right: Vector2) -> Vector2 {
        return Vector2(left.x - right.x, left.y - right.y)
    }

    /// Multiplies the components of two `Vector2`s by each other.
    ///
    /// - Parameters:
    ///   - left: Source `Vector2` on the left of the multiplication sign.
    ///   - right: Source `Vector2` on the right of the multiplication sign.
    ///
    /// - Returns:Result of the vector multiplication.

    @inlinable
    static func * (left: Vector2, right: Vector2) -> Vector2 {
        return Vector2(left.x * right.x, left.y * right.y)
    }

    /// Multiplies the components of a`Vector2` by a scalar.
    ///
    /// - Parameters:
    ///   - left: Source `Vector2` on the left of the multiplication sign.
    ///   - right: Scalar value on the right of the multiplication sign.
    ///
    /// - Returns:Result of the vector multiplication by a scalar.

    @inlinable
    static func * (left: Vector2, right: Float) -> Vector2 {
        return Vector2(left.x * right, left.y * right)
    }

    /// Multiplies the components of a`Vector2` by a scalar.
    ///
    /// - Parameters:
    ///   - left: Scalar value on the left of the multiplication sign.
    ///   - right: Source `Vector2` on the right of the multiplication sign.
    ///
    /// - Returns:Result of the vector multiplication by a scalar.

    @inlinable
    static func * (left: Float, right: Vector2) -> Vector2 {
        return Vector2(left * right.x, left * right.y)
    }

    /// Divides the components of two `Vector2`s by each other.
    ///
    /// - Parameters:
    ///   - left: Source `Vector2` on the left of the division sign.
    ///   - right: Source `Vector2` on the right of the division sign.
    ///
    /// - Returns:Result of the vector division.

    @inlinable
    @inline(__always)
    static func / (left: Vector2, right: Vector2) -> Vector2 {
        return Vector2(left.x / right.x, left.y / right.y)
    }

    /// Divides the components of a`Vector2` by a scalar.
    ///
    /// - Parameters:
    ///   - left: Source `Vector2` on the left of the division sign.
    ///   - right: Scalar value on the right of the division sign.
    ///
    /// - Returns:Result of the vector division by a scalar.

    @inlinable
    @inline(__always)
    static func / (left: Vector2, right: Float) -> Vector2 {
        let factor = 1.0 / right
        return Vector2(left.x * factor, left.y * factor)
    }
}
