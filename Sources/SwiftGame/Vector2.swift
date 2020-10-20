//
//  Vector2.swift
//  
//
//  Created by David Green on 10/5/20.
//

import Foundation

/// Describes a 2D vector

public struct Vector2: Equatable, Codable, CustomDebugStringConvertible, Hashable {
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
    ///   - result: The result of the interpolation as an `inout` parameter.
    static func catmullRom(_ value1: Vector2, _ value2: Vector2, _ value3: Vector2, _ value4: Vector2, amount: Float, result: inout Vector2) {
        result.x = MathHelper.catmullRom(value1.x, value2.x, value3.x, value4.x, amount: amount)
        result.y = MathHelper.catmullRom(value1.y, value2.y, value3.y, value4.y, amount: amount)
    }

    /// Round the members of this `Vector2` towards positive infinity.
    /// - Returns: The rounded vector
    var ceiling: Vector2 {
        return Vector2(x.rounded(.up), y.rounded(.up))
    }

    /// Clamp the components of the vector within a specified range.
    /// - Parameters:
    ///   - min: The minimum component values.
    ///   - max: The maximum component values.
    /// - Returns: The clamped vector.
    func clamped(between min: Vector2, and max: Vector2) -> Vector2 {
        return Vector2(MathHelper.clamp(x, min: min.x, max: max.x),
                       MathHelper.clamp(y, min: min.y, max: max.y))
    }

    /// Clamp the components of the vector within a specified range.
    /// - Parameters:
    ///   - min: The minimum component values.
    ///   - max: The maximum component values.
    mutating func clamp(between min: Vector2, and max: Vector2) {
        x = MathHelper.clamp(x, min: min.x, max: max.x)
        y = MathHelper.clamp(y, min: min.y, max: max.y)
    }

    /// Returns the distance between two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    /// - Returns: The distance between two vectors
    static func distance(_ value1: Vector2, _ value2: Vector2) -> Float {
        return distanceSquared(value1, value2).squareRoot()
    }

    /// Returns the distance between two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - result: The distance between two vectors as an `inout` parameter.
    static func distance(_ value1: Vector2, _ value2: Vector2, result: inout Float) {
        result = distance(value1, value2)
    }

    /// Returns the squared distance between two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    /// - Returns: The squared distance between two vectors.
    static func distanceSquared(_ value1: Vector2, _ value2: Vector2) -> Float {
        let v1 = value1.x - value2.x, v2 = value1.y - value2.y
        return (v1 * v1) + (v2 * v2)
    }

    /// Returns the squared distance between two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - result: The squared distance between two vectors as an `inout` parameter.
    static func distanceSquared(_ value1: Vector2, _ value2: Vector2, result: inout Float) {
        result = distanceSquared(value1, value2)
    }
    
    /// Returns the dot product of two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    /// - Returns: The dot product of the two vectors.
    static func dot(_ value1: Vector2, _ value2: Vector2) -> Float {
        return value1.x * value2.x + value1.y * value2.y
    }
    
    /// Returns the dot product of two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - result: The dot product of the two vectors as an `inout` parameter.
    static func dot(_ value1: Vector2, _ value2: Vector2, result: inout Float) {
        result = dot(value1, value2)
    }
    
    /// Returns a new vector that contains the members of the original vector rounded towards negative infinity.
    var floor: Vector2 {
        return Vector2(x.rounded(.down), y.rounded(.down))
    }
    
    /// Creates a new `Vector2` that contains a hermite spline interpolation.
    /// - Parameters:
    ///   - value1: The first position vector.
    ///   - tangent1: The first tangent vector.
    ///   - value2: The second position vector.
    ///   - tangent2: The second tangent vector.
    ///   - amount: Weighting factor.
    /// - Returns: The hermite spline interpolated vector.
    static func hermite(_ value1: Vector2, tangent1: Vector2, _ value2: Vector2, tangent2: Vector2, amount: Float) -> Vector2 {
        return Vector2(
            MathHelper.hermite(value1.x, tangent1: tangent1.x, value2.x, tangent2: tangent2.x, amount: amount),
            MathHelper.hermite(value1.y, tangent1: tangent1.y, value2.y, tangent2: tangent2.y, amount: amount)
        )
    }
    
    /// Creates a new `Vector2` that contains a hermite spline interpolation.
    /// - Parameters:
    ///   - value1: The first position vector.
    ///   - tangent1: The first tangent vector.
    ///   - value2: The second position vector.
    ///   - tangent2: The second tangent vector.
    ///   - amount: Weighting factor.
    ///   - result: The hermite spline interpolated vector as an `inout` value.
    static func hermite(_ value1: Vector2, tangent1: Vector2, _ value2: Vector2, tangent2: Vector2, amount: Float, result: inout Vector2) {
        result = hermite(value1, tangent1: tangent1, value2, tangent2: tangent2, amount: amount)
    }

    /// The length of this vector.
    var length: Float {
        return Float(((x * x) + (y * y)).squareRoot())
    }
    
    /// The squared length of this vector.
    var lengthSquared: Float {
        return Float(((x * x) + (y * y)))
    }
    
    /// Creates a vector that contains the linear interpolation of the specified vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - amount: Weighting value (between 0.0 and 1.0).
    /// - Returns: The result of the linear interpolation of the specified vectors.
    static func lerp(_ value1: Vector2, _ value2: Vector2, amount: Float) -> Vector2 {
        return Vector2(MathHelper.lerp(value1.x, value2.x, amount: amount),
                       MathHelper.lerp(value1.y, value2.y, amount: amount))
    }
    
    /// Creates a vector that contains the linear interpolation of the specified vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - amount: Weighting value (between 0.0 and 1.0).
    ///   - result: The result of the linear interpolation of the specified vectors as an `inout` parameter.
    static func lerp(_ value1: Vector2, _ value2: Vector2, amount: Float, result: inout Vector2) {
        result.x = MathHelper.lerp(value1.x, value2.x, amount: amount)
        result.y = MathHelper.lerp(value1.y, value2.y, amount: amount)
    }
    
    /// Creates a vector that contains the linear interpolation of the specified vectors.
    /// Uses `MathHelper.lerpPrecise` for the interpolation for less efficient but more accurate results.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - amount: Weighting value (between 0.0 and 1.0).
    /// - Returns: The result of the linear interpolation of the specified vectors.
    static func lerpPrecise(_ value1: Vector2, _ value2: Vector2, amount: Float) -> Vector2 {
        return Vector2(MathHelper.lerpPrecise(value1.x, value2.x, amount: amount),
                       MathHelper.lerpPrecise(value1.y, value2.y, amount: amount))
    }
    
    /// Creates a vector that contains the linear interpolation of the specified vectors.
    /// Uses `MathHelper.lerpPrecise` for the interpolation for less efficient but more accurate results.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - amount: Weighting value (between 0.0 and 1.0).
    ///   - result: The result of the linear interpolation of the specified vectors as an `inout` parameter.
    static func lerpPrecise(_ value1: Vector2, _ value2: Vector2, amount: Float, result: inout Vector2) {
        result.x = MathHelper.lerpPrecise(value1.x, value2.x, amount: amount)
        result.y = MathHelper.lerpPrecise(value1.y, value2.y, amount: amount)
    }
    
    /// Returns a vector that contains the maximal component values from two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    /// - Returns: A Vector containing the maximal components from each source vector.
    static func max(_ value1: Vector2, _ value2: Vector2) -> Vector2 {
        return Vector2(
            Swift.max(value1.x, value2.x),
            Swift.max(value1.y, value2.y)
        )
    }
    
    /// Returns a vector that contains the maximal component values from two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - result: A Vector containing the maximal components from each source vector as an `inout` parameter.
    static func max(_ value1: Vector2, _ value2: Vector2, result: inout Vector2) {
        result.x = Swift.max(value1.x, value2.x)
        result.y = Swift.max(value1.y, value2.y)
    }
    
    /// Returns a vector that contains the minimal component values from two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    /// - Returns: A Vector containing the minimal components from each source vector.
    static func min(_ value1: Vector2, _ value2: Vector2) -> Vector2 {
        return Vector2(
            Swift.min(value1.x, value2.x),
            Swift.min(value1.y, value2.y)
        )
    }
    
    /// Returns a vector that contains the minimal component values from two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - result: A Vector containing the minimal components from each source vector as an `inout` parameter.
    static func min(_ value1: Vector2, _ value2: Vector2, result: inout Vector2) {
        result.x = Swift.min(value1.x, value2.x)
        result.y = Swift.min(value1.y, value2.y)
    }
    
    /// Returns a vector containing the normalized vector for a vector.
    var normalized: Vector2 {
        let factor = 1.0 / self.length
        return Vector2(x * factor, y * factor)
    }
    
    /// Returns a vector containing the members of this vector rounded to the nearest integer.
    var rounded: Vector2 {
        return Vector2(x.rounded(), y.rounded())
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
