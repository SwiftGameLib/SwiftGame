//
//  Vector3.swift
//  
//
//  Created by David Green on 10/5/20.
//

import Foundation

/// Describes a 3D vector

public struct Vector3: Equatable, Codable, CustomDebugStringConvertible, Hashable {
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
    public static let right: Vector3 = Vector3(1, 0, 0)

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

    public init(_ value: Vector2, _ z: Float) {
        x = value.x
        y = value.y
        self.z = z
    }
}

// MARK: - Public methods

public extension Vector3 {

    /// Creates a new `Vector3` that contains the cartesian coordinates of a vector specified in barycentric coordinates and relative to a 3d triangle.
    /// - Parameters:
    ///   - value1: The first vector of a 3d triangle.
    ///   - value2: The second vector of a 3d triangle.
    ///   - value3: The third vector of a 3d triangle.
    ///   - amount1: Barycentric scalar **b2** which represents a weighting factor towards the second vector of the 3d triangle.
    ///   - amount2: Barycentric scalar **b3** which represents a weighting factor towards the third vector of the 3d triangle.
    /// - Returns: The cartesian translation of barycentric coordinates.
    static func barycentric(_ value1: Vector3, _ value2: Vector3, _ value3: Vector3, amount1: Float, amount2: Float) -> Vector3 {
        return Vector3(
            MathHelper.barycentric(value1.x, value2.x, value3.x, amount1: amount1, amount2: amount2),
            MathHelper.barycentric(value1.y, value2.y, value3.y, amount1: amount1, amount2: amount2),
            MathHelper.barycentric(value1.z, value2.z, value3.z, amount1: amount1, amount2: amount2))
    }

    /// Creates a new `Vector3` that contains the cartesian coordinates of a vector specified in barycentric coordinates and relative to a 3d triangle.
    /// - Parameters:
    ///   - value1: The first vector of a 3d triangle.
    ///   - value2: The second vector of a 3d triangle.
    ///   - value3: The third vector of a 3d triangle.
    ///   - amount1: Barycentric scalar **b2** which represents a weighting factor towards the second vector of the 3d triangle.
    ///   - amount2: Barycentric scalar **b3** which represents a weighting factor towards the third vector of the 3d triangle.
    ///   - result: The cartesian translation of barycentric coordinates as an `inout` parameter.
    static func barycentric(_ value1: Vector3, _ value2: Vector3, _ value3: Vector3, amount1: Float, amount2: Float, result: inout Vector3) {
        result.x = MathHelper.barycentric(value1.x, value2.x, value3.x, amount1: amount1, amount2: amount2)
        result.y = MathHelper.barycentric(value1.y, value2.y, value3.y, amount1: amount1, amount2: amount2)
        result.z = MathHelper.barycentric(value1.z, value2.z, value3.z, amount1: amount1, amount2: amount2)
    }

    /// Creates a new `Vector3` that contains the Catmull Rom interpolation of the specified vectors.
    /// - Parameters:
    ///   - value1: The first vector in the interpolation.
    ///   - value2: The second vector in the interpolation.
    ///   - value3: The third vector in the interpolation.
    ///   - value4: The fourth vector in the interpolation.
    ///   - amount: Weighting factor.
    /// - Returns: The result of the interpolation.
    static func catmullRom(_ value1: Vector3, _ value2: Vector3, _ value3: Vector3, _ value4: Vector3, amount: Float) -> Vector3 {
        return Vector3(
            MathHelper.catmullRom(value1.x, value2.x, value3.x, value4.x, amount: amount),
            MathHelper.catmullRom(value1.y, value2.y, value3.y, value4.y, amount: amount),
            MathHelper.catmullRom(value1.z, value2.z, value3.z, value4.z, amount: amount))
    }

    /// Creates a new `Vector3` that contains the Catmull Rom interpolation of the specified vectors.
    /// - Parameters:
    ///   - value1: The first vector in the interpolation.
    ///   - value2: The second vector in the interpolation.
    ///   - value3: The third vector in the interpolation.
    ///   - value4: The fourth vector in the interpolation.
    ///   - amount: Weighting factor.
    ///   - result: The result of the interpolation as an `inout` parameter.
    static func catmullRom(_ value1: Vector3, _ value2: Vector3, _ value3: Vector3, _ value4: Vector3, amount: Float, result: inout Vector3) {
        result.x = MathHelper.catmullRom(value1.x, value2.x, value3.x, value4.x, amount: amount)
        result.y = MathHelper.catmullRom(value1.y, value2.y, value3.y, value4.y, amount: amount)
        result.z = MathHelper.catmullRom(value1.z, value2.z, value3.z, value4.z, amount: amount)
    }

    /// Round the members of this `Vector3` towards positive infinity.
    /// - Returns: The rounded vector
    var ceiling: Vector3 {
        return Vector3(x.rounded(.up), y.rounded(.up), z.rounded(.up))
    }

    /// Clamp the components of the vector within a specified range.
    /// - Parameters:
    ///   - min: The minimum component values.
    ///   - max: The maximum component values.
    /// - Returns: The clamped vector.
    func clamped(between min: Vector3, and max: Vector3) -> Vector3 {
        return Vector3(MathHelper.clamp(x, min: min.x, max: max.x),
                       MathHelper.clamp(y, min: min.y, max: max.y),
                       MathHelper.clamp(z, min: min.z, max: max.z))
    }

    /// Clamp the components of the vector within a specified range.
    /// - Parameters:
    ///   - min: The minimum component values.
    ///   - max: The maximum component values.
    mutating func clamp(between min: Vector3, and max: Vector3) {
        x = MathHelper.clamp(x, min: min.x, max: max.x)
        y = MathHelper.clamp(y, min: min.y, max: max.y)
        z = MathHelper.clamp(z, min: min.z, max: max.z)
    }

    /// Computes the cross product of two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    /// - Returns: The cross product of the two vectors.
    static func cross(_ value1: Vector3, _ value2: Vector3) -> Vector3 {
        return Vector3(value1.y * value2.z - value2.y * value1.z,
                       -(value1.x * value2.z - value2.x * value1.z),
                       value1.x * value2.y - value2.x * value1.y)
    }

    /// Computes the cross product of two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - result: The cross product of the two vectors as an `inout` parameter.
    static func cross(_ value1: Vector3, _ value2: Vector3, result: inout Vector3) {
        result = cross(value1, value2)
    }

    /// Computes the cross product of this and an other vector.
    /// - Parameter other: The second vector.
    /// - Returns: The cross product of the two vectors.
    func cross(_ other: Vector3) -> Vector3 {
        return Vector3.cross(self, other)
    }

    /// Returns the distance between two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    /// - Returns: The distance between two vectors
    static func distance(_ value1: Vector3, _ value2: Vector3) -> Float {
        return distanceSquared(value1, value2).squareRoot()
    }

    /// Returns the distance between two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - result: The distance between two vectors as an `inout` parameter.
    static func distance(_ value1: Vector3, _ value2: Vector3, result: inout Float) {
        result = distance(value1, value2)
    }

    /// Returns the squared distance between two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    /// - Returns: The squared distance between two vectors.
    static func distanceSquared(_ value1: Vector3, _ value2: Vector3) -> Float {
        let v1 = value1.x - value2.x, v2 = value1.y - value2.y, v3 = value1.z - value2.z
        return (v1 * v1) + (v2 * v2) + (v3 * v3)
    }

    /// Returns the squared distance between two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - result: The squared distance between two vectors as an `inout` parameter.
    static func distanceSquared(_ value1: Vector3, _ value2: Vector3, result: inout Float) {
        result = distanceSquared(value1, value2)
    }
    
    /// Returns the dot product of two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    /// - Returns: The dot product of the two vectors.
    static func dot(_ value1: Vector3, _ value2: Vector3) -> Float {
        return value1.x * value2.x + value1.y * value2.y + value1.z * value2.z
    }
    
    /// Returns the dot product of two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - result: The dot product of the two vectors as an `inout` parameter.
    static func dot(_ value1: Vector3, _ value2: Vector3, result: inout Float) {
        result = dot(value1, value2)
    }
    
    /// Returns a new vector that contains the members of the original vector rounded towards negative infinity.
    var floor: Vector3 {
        return Vector3(x.rounded(.down), y.rounded(.down), z.rounded(.down))
    }
    
    /// Creates a new `Vector3` that contains a hermite spline interpolation.
    /// - Parameters:
    ///   - value1: The first position vector.
    ///   - tangent1: The first tangent vector.
    ///   - value2: The second position vector.
    ///   - tangent2: The second tangent vector.
    ///   - amount: Weighting factor.
    /// - Returns: The hermite spline interpolated vector.
    static func hermite(_ value1: Vector3, tangent1: Vector3, _ value2: Vector3, tangent2: Vector3, amount: Float) -> Vector3 {
        return Vector3(
            MathHelper.hermite(value1.x, tangent1: tangent1.x, value2.x, tangent2: tangent2.x, amount: amount),
            MathHelper.hermite(value1.y, tangent1: tangent1.y, value2.y, tangent2: tangent2.y, amount: amount),
            MathHelper.hermite(value1.z, tangent1: tangent1.z, value2.z, tangent2: tangent2.z, amount: amount)
        )
    }
    
    /// Creates a new `Vector3` that contains a hermite spline interpolation.
    /// - Parameters:
    ///   - value1: The first position vector.
    ///   - tangent1: The first tangent vector.
    ///   - value2: The second position vector.
    ///   - tangent2: The second tangent vector.
    ///   - amount: Weighting factor.
    ///   - result: The hermite spline interpolated vector as an `inout` value.
    static func hermite(_ value1: Vector3, tangent1: Vector3, _ value2: Vector3, tangent2: Vector3, amount: Float, result: inout Vector3) {
        result = hermite(value1, tangent1: tangent1, value2, tangent2: tangent2, amount: amount)
    }

    /// The length of this vector.
    var length: Float {
        return Float(((x * x) + (y * y) + (z * z)).squareRoot())
    }
    
    /// The squared length of this vector.
    var lengthSquared: Float {
        return Float(((x * x) + (y * y) + (z * z)))
    }
    
    /// Creates a vector that contains the linear interpolation of the specified vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - amount: Weighting value (between 0.0 and 1.0).
    /// - Returns: The result of the linear interpolation of the specified vectors.
    static func lerp(_ value1: Vector3, _ value2: Vector3, amount: Float) -> Vector3 {
        return Vector3(MathHelper.lerp(value1.x, value2.x, amount: amount),
                       MathHelper.lerp(value1.y, value2.y, amount: amount),
                       MathHelper.lerp(value1.z, value2.z, amount: amount))
    }
    
    /// Creates a vector that contains the linear interpolation of the specified vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - amount: Weighting value (between 0.0 and 1.0).
    ///   - result: The result of the linear interpolation of the specified vectors as an `inout` parameter.
    static func lerp(_ value1: Vector3, _ value2: Vector3, amount: Float, result: inout Vector3) {
        result.x = MathHelper.lerp(value1.x, value2.x, amount: amount)
        result.y = MathHelper.lerp(value1.y, value2.y, amount: amount)
        result.z = MathHelper.lerp(value1.z, value2.z, amount: amount)
    }
    
    /// Creates a vector that contains the linear interpolation of the specified vectors.
    /// Uses `MathHelper.lerpPrecise` for the interpolation for less efficient but more accurate results.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - amount: Weighting value (between 0.0 and 1.0).
    /// - Returns: The result of the linear interpolation of the specified vectors.
    static func lerpPrecise(_ value1: Vector3, _ value2: Vector3, amount: Float) -> Vector3 {
        return Vector3(MathHelper.lerpPrecise(value1.x, value2.x, amount: amount),
                       MathHelper.lerpPrecise(value1.y, value2.y, amount: amount),
                       MathHelper.lerpPrecise(value1.z, value2.z, amount: amount))
    }
    
    /// Creates a vector that contains the linear interpolation of the specified vectors.
    /// Uses `MathHelper.lerpPrecise` for the interpolation for less efficient but more accurate results.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - amount: Weighting value (between 0.0 and 1.0).
    ///   - result: The result of the linear interpolation of the specified vectors as an `inout` parameter.
    static func lerpPrecise(_ value1: Vector3, _ value2: Vector3, amount: Float, result: inout Vector3) {
        result.x = MathHelper.lerpPrecise(value1.x, value2.x, amount: amount)
        result.y = MathHelper.lerpPrecise(value1.y, value2.y, amount: amount)
        result.z = MathHelper.lerpPrecise(value1.z, value2.z, amount: amount)
    }
    
    /// Returns a vector that contains the maximal component values from two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    /// - Returns: A Vector containing the maximal components from each source vector.
    static func max(_ value1: Vector3, _ value2: Vector3) -> Vector3 {
        return Vector3(
            Swift.max(value1.x, value2.x),
            Swift.max(value1.y, value2.y),
            Swift.max(value1.z, value2.z)
        )
    }
    
    /// Returns a vector that contains the maximal component values from two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - result: A Vector containing the maximal components from each source vector as an `inout` parameter.
    static func max(_ value1: Vector3, _ value2: Vector3, result: inout Vector3) {
        result.x = Swift.max(value1.x, value2.x)
        result.y = Swift.max(value1.y, value2.y)
        result.z = Swift.max(value1.z, value2.z)
    }
    
    /// Returns a vector that contains the minimal component values from two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    /// - Returns: A Vector containing the minimal components from each source vector.
    static func min(_ value1: Vector3, _ value2: Vector3) -> Vector3 {
        return Vector3(
            Swift.min(value1.x, value2.x),
            Swift.min(value1.y, value2.y),
            Swift.min(value1.z, value2.z)
        )
    }
    
    /// Returns a vector that contains the minimal component values from two vectors.
    /// - Parameters:
    ///   - value1: The first vector.
    ///   - value2: The second vector.
    ///   - result: A Vector containing the minimal components from each source vector as an `inout` parameter.
    static func min(_ value1: Vector3, _ value2: Vector3, result: inout Vector3) {
        result.x = Swift.min(value1.x, value2.x)
        result.y = Swift.min(value1.y, value2.y)
        result.z = Swift.min(value1.z, value2.z)
    }
    
    /// Returns a vector containing the normalized vector for a vector.
    var normalized: Vector3 {
        let factor = 1.0 / self.length
        return Vector3(x * factor, y * factor, z * factor)
    }
    
    /// Returns a vector containing the members of this vector rounded to the nearest integer.
    var rounded: Vector3 {
        return Vector3(x.rounded(), y.rounded(), z.rounded())
    }
}

// MARK: - Operators

public extension Vector3 {

    /// Inverts the values in the `Vector3`.
    ///
    /// - Parameters:
    ///   - vector: Source `Vector3` on the right of the negative sign.
    ///
    /// - Returns:Result of the inversion.

    @inlinable
    static prefix func - (vector: Vector3) -> Vector3 {
        return Vector3(-vector.x, -vector.y, -vector.z)
    }

    /// Adds two vectors.
    ///
    /// - Parameters:
    ///   - left: Source `Vector3` on the left of the plus sign.
    ///   - right: Source `Vector3` on the right of the plus] sign.
    ///
    /// - Returns:Sum of the vectors.

    @inlinable
    static func + (left: Vector3, right: Vector3) -> Vector3 {
        return Vector3(left.x + right.x, left.y + right.y, left.z + right.z)
    }

    /// Subtracts a `Vector3` from a `Vector3`.
    ///
    /// - Parameters:
    ///   - left: Source `Vector3` on the left of the minus sign.
    ///   - right: Source `Vector3` on the right of the minus sign.
    ///
    /// - Returns:Result of the vector subtraction.

    @inlinable
    static func - (left: Vector3, right: Vector3) -> Vector3 {
        return Vector3(left.x - right.x, left.y - right.y, left.z - right.z)
    }

    /// Multiplies the components of two `Vector3`s by each other.
    ///
    /// - Parameters:
    ///   - left: Source `Vector3` on the left of the multiplication sign.
    ///   - right: Source `Vector3` on the right of the multiplication sign.
    ///
    /// - Returns:Result of the vector multiplication.

    @inlinable
    static func * (left: Vector3, right: Vector3) -> Vector3 {
        return Vector3(left.x * right.x, left.y * right.y, left.z * right.z)
    }

    /// Multiplies the components of a`Vector3` by a scalar.
    ///
    /// - Parameters:
    ///   - left: Source `Vector3` on the left of the multiplication sign.
    ///   - right: Scalar value on the right of the multiplication sign.
    ///
    /// - Returns:Result of the vector multiplication by a scalar.

    @inlinable
    static func * (left: Vector3, right: Float) -> Vector3 {
        return Vector3(left.x * right, left.y * right, left.z * right)
    }

    /// Multiplies the components of a`Vector3` by a scalar.
    ///
    /// - Parameters:
    ///   - left: Scalar value on the left of the multiplication sign.
    ///   - right: Source `Vector3` on the right of the multiplication sign.
    ///
    /// - Returns:Result of the vector multiplication by a scalar.

    @inlinable
    static func * (left: Float, right: Vector3) -> Vector3 {
        return Vector3(left * right.x, left * right.y, left * right.z)
    }

    /// Divides the components of two `Vector3`s by each other.
    ///
    /// - Parameters:
    ///   - left: Source `Vector3` on the left of the division sign.
    ///   - right: Source `Vector3` on the right of the division sign.
    ///
    /// - Returns:Result of the vector division.

    @inlinable
    @inline(__always)
    static func / (left: Vector3, right: Vector3) -> Vector3 {
        return Vector3(left.x / right.x, left.y / right.y, left.z / right.z)
    }

    /// Divides the components of a`Vector3` by a scalar.
    ///
    /// - Parameters:
    ///   - left: Source `Vector3` on the left of the division sign.
    ///   - right: Scalar value on the right of the division sign.
    ///
    /// - Returns:Result of the vector division by a scalar.

    @inlinable
    @inline(__always)
    static func / (left: Vector3, right: Float) -> Vector3 {
        let factor = 1.0 / right
        return Vector3(left.x * factor, left.y * factor, left.z * factor)
    }
}
