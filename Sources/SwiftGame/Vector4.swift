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

// MARK: - Public methods

public extension Vector4 {

    /// Creates a new `Vector4` that contains the cartesian coordinates of a vector specified in barycentric coordinates and relative to a 4d triangle.
    /// - Parameters:
    ///   - value1: The first vector of a 3d triangle.
    ///   - value2: The second vector of a 3d triangle.
    ///   - value3: The third vector of a 3d triangle.
    ///   - amount1: Barycentric scalar **b2** which represents a weighting factor towards the second vector of the 3d triangle.
    ///   - amount2: Barycentric scalar **b3** which represents a weighting factor towards the third vector of the 3d triangle.
    /// - Returns: The cartesian translation of barycentric coordinates.
    static func barycentric(_ value1: Vector4, _ value2: Vector4, _ value3: Vector4, amount1: Float, amount2: Float) -> Vector4 {
        return Vector4(
            MathHelper.barycentric(value1.x, value2.x, value3.x, amount1: amount1, amount2: amount2),
            MathHelper.barycentric(value1.y, value2.y, value3.y, amount1: amount1, amount2: amount2),
            MathHelper.barycentric(value1.z, value2.z, value3.z, amount1: amount1, amount2: amount2),
            MathHelper.barycentric(value1.w, value2.w, value3.w, amount1: amount1, amount2: amount2))
    }

    /// Creates a new `Vector4` that contains the cartesian coordinates of a vector specified in barycentric coordinates and relative to a 3d triangle.
    /// - Parameters:
    ///   - value1: The first vector of a 3d triangle.
    ///   - value2: The second vector of a 3d triangle.
    ///   - value3: The third vector of a 3d triangle.
    ///   - amount1: Barycentric scalar **b2** which represents a weighting factor towards the second vector of the 3d triangle.
    ///   - amount2: Barycentric scalar **b3** which represents a weighting factor towards the third vector of the 3d triangle.
    ///   - result: The cartesian translation of barycentric coordinates as an `inout` parameter.
    static func barycentric(_ value1: Vector4, _ value2: Vector4, _ value3: Vector4, amount1: Float, amount2: Float, result: inout Vector4) {
        result.x = MathHelper.barycentric(value1.x, value2.x, value3.x, amount1: amount1, amount2: amount2)
        result.y = MathHelper.barycentric(value1.y, value2.y, value3.y, amount1: amount1, amount2: amount2)
        result.z = MathHelper.barycentric(value1.z, value2.z, value3.z, amount1: amount1, amount2: amount2)
        result.w = MathHelper.barycentric(value1.w, value2.w, value3.w, amount1: amount1, amount2: amount2)
    }

    /// Creates a new `Vector4` that contains the Catmull Rom interpolation of the specified vectors.
    /// - Parameters:
    ///   - value1: The first vector in the interpolation.
    ///   - value2: The second vector in the interpolation.
    ///   - value3: The third vector in the interpolation.
    ///   - value4: The fourth vector in the interpolation.
    ///   - amount: Weighting factor.
    /// - Returns: The result of the interpolation.
    static func catmullRom(_ value1: Vector4, _ value2: Vector4, _ value3: Vector4, _ value4: Vector4, amount: Float) -> Vector4 {
        return Vector4(
            MathHelper.catmullRom(value1.x, value2.x, value3.x, value4.x, amount: amount),
            MathHelper.catmullRom(value1.y, value2.y, value3.y, value4.y, amount: amount),
            MathHelper.catmullRom(value1.z, value2.z, value3.z, value4.z, amount: amount),
            MathHelper.catmullRom(value1.w, value2.w, value3.w, value4.w, amount: amount))
    }

    /// Creates a new `Vector4` that contains the Catmull Rom interpolation of the specified vectors.
    /// - Parameters:
    ///   - value1: The first vector in the interpolation.
    ///   - value2: The second vector in the interpolation.
    ///   - value3: The third vector in the interpolation.
    ///   - value4: The fourth vector in the interpolation.
    ///   - amount: Weighting factor.
    ///   - result: The result of the interpolation as an `inout` parameter..
    static func catmullRom(_ value1: Vector4, _ value2: Vector4, _ value3: Vector4, _ value4: Vector4, amount: Float, result: inout Vector4) {
        result.x = MathHelper.catmullRom(value1.x, value2.x, value3.x, value4.x, amount: amount)
        result.y = MathHelper.catmullRom(value1.y, value2.y, value3.y, value4.y, amount: amount)
        result.z = MathHelper.catmullRom(value1.z, value2.z, value3.z, value4.z, amount: amount)
        result.w = MathHelper.catmullRom(value1.w, value2.w, value3.w, value4.w, amount: amount)
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
