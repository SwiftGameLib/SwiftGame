//
//  MathHelper.swift
//  
//
//  Created by David Green on 10/5/20.
//

import Foundation


/// Contains commonly used values and mathematical operations

public final class MathHelper {

    /// Represents the mathematical constant e (`2.71828175`).
    public static let e: Float = Float(M_E)

    /// Represents the log base ten of e (`0.4342945`).
    public static let log10E: Float = 0.4342945

    /// Represents the log base two of e (`1.442695`).
    public static let log2E: Float = 1.442695

    /// Represents the value of pi (`3.14159274`).
    public static let pi: Float = Float(Float64.pi)

    /// Represents the value of pi divided by two (`1.57079637`).
    public static let piOver2: Float = Float(Float64.pi) / 2.0

    /// Represents the value of pi divided by 4 (`0.7853982`).
    public static let piOver4: Float = Float(Float64.pi) / 4.0

    /// Represents the value of pi times two (`6.28318548`).
    public static let twoPi: Float = Float(Float64.pi) * 2.0

    /// Represents the value of pi times two (`6.28318548`).
    /// This is an alias of twoPi.
    public static let tau: Float = twoPi

    /**
     Returns the Cartesian coordinate for one axis of a point that is defined by a given triangle and two normalized barycentric (areal) coordinates.

     - Parameters:
        - value1: The coordinate on one axis of vertex 1 of the defining triangle.
        - value2: The coordinate on the same axis of vertex 2 of the defining triangle.
        - value3: The coordinate on the same axis of vertex 3 of the defining triangle.
        - amount1: The normalized barycentric (areal) coordinate b2, equal to the weighting factor for vertex 2, the coordinate of which is specified in `value2`.
        - amount2: The normalized barycentric (areal) coordinate b3, equal to the weighting factor for vertex 3, the coordinate of which is specified in `value3`.
     - Returns: Cartesian coordinate of the specified point with respect to the axis being used.
     */
    public static func barycentric(_ value1: Float, _ value2: Float, _ value3: Float, amount1: Float, amount2: Float) -> Float {
        return value1 + (value2 - value1) * amount1 + (value3 - value1) * amount2
    }

    /**
     Performs a Catmull-Rom interpolation using the specified positions.

     - Parameters:
        - value1: The first position in the interpolation.
        - value2: The second position in the interpolation.
        - value3: The third position in the interpolation.
        - value4: The fourth position in the interpolation.
        - amount: Weighting factor
     - Returns: A position that is the result of the Catmull-Rom interpolation.
     */
    public static func catmullRom(_ value1: Float, _ value2: Float, _ value3: Float, _ value4: Float, amount: Float) -> Float {
        // Using formula from http://www.mvps.org/directx/articles/catmull/
        // Internally using Float64 to avoid losing precision.
        let value1 = Float64(value1)
        let value2 = Float64(value2)
        let value3 = Float64(value3)
        let value4 = Float64(value4)

        let amount = Float64(amount)

        let amountSquared = amount * amount
        let amountCubed = amountSquared * amount

        return Float(0.5 * (2.0 * value2 +
                                (value3 - value1) * amount +
                                (2.0 * value1 - 5.0 * value2 + 4.0 * value3 - value4) * amountSquared +
                                (3.0 * value2 - value1 - 3.0 * value3 + value4) * amountCubed))
    }

    /**
     Restricts a value to be within a specified range.

     - Parameters:
        - value: The value to clamp.
        - min: The minimum value. If `value` is less than `min`, `min` will be returned.
        - max: The maximum value. If `value` is greater than `max`, `max` will be returned.
     - Returns: The clamped value.
     */
    public static func clamp(_ value: Float, min: Float, max: Float) -> Float {
        var value = (value > max) ? max : value
        value = (value < min) ? min : value
        return value
    }

    /**
     Restricts a value to be within a specified range.

     - Parameters:
        - value: The value to clamp.
        - min: The minimum value. If `value` is less than `min`, `min` will be returned.
        - max: The maximum value. If `value` is greater than `max`, `max` will be returned.
     - Returns: The clamped value.
     */
    public static func clamp(_ value: Int, min: Int, max: Int) -> Int {
        var value = (value > max) ? max : value
        value = (value < min) ? min : value
        return value
    }

    /**
     Calculates the absolute value of the difference of two values.

     - Parameters:
        - value1: Source value.
        - value2: Source value.
     - Returns:Distance between the two values.
     */
    public static func distance(_ value1: Float, _ value2: Float) -> Float {
        return abs(value1 - value2)
    }

    /**
     Performs a Hermite spline interpolation.

     - Parameters:
        - value1: Source position.
        - tangent1: Source tangent.
        - value2: Destination position.
        - tangent2: Destination tangent.
        - amount: Weighting factor.
     - Returns: The result of the Hermite spline interpolation.
     */
    public static func hermite(_ value1: Float, tangent1: Float, _ value2: Float, tangent2: Float, amount: Float) -> Float {
        // All transformed to Float64 to void losing precision.
        // Otherwise, for high values of param:amount the result is NaN instead of Infinity.
        let value1 = Float64(value1)
        let tangent1 = Float64(tangent1)
        let value2 = Float64(value2)
        let tangent2 = Float64(tangent2)
        let amount = Float64(amount)

        let amountCubed = amount * amount * amount
        let amountSquared = amount * amount

        var result: Float64 = 0.0

        if amount == 0.0 {
            result = value1
        } else if amount == 1.0 {
            result = value2
        } else {
            result = (2 * value1 - 2 * value2 + tangent2 + tangent1) * amountCubed +
                (3 * value2 - 3 * value1 - 2 * tangent1 - tangent2) * amountSquared +
                tangent1 * amount +
                value1
        }
        return Float(result)
    }

    /**
     Linearly interpolates between two values.

     - Parameters:
        - value1: Source value.
        - value2: Destination value.
        - amount: Value between 0 and 1 indicating the weight of `value2`.
     - Returns: Interpolated value.
     - Remark: This method performs the linear interpolation based on the following formula:
     ```
     value1 + (value2 - value1) * amount
     ```
     Passing `amount` a value of 0 will cause `value1` to be returned, a value of 1 will cause `value2` to be returned.

     See `lerpPrecise()` for a less efficient version with more precision around edge cases.
     */
    public static func lerp(_ value1: Float,_ value2: Float, amount: Float) -> Float {
        return value1 + (value2 - value1) * amount
    }

    /**
     Linearly interpolates between two values.
     This method is a less efficient, more precise version of `lerp()`.
     See remarks for more info.

     - Parameters:
        - value1: Source value.
        - value2: Destination value.
        - amount: Value between 0 and 1 indicating the weight of `value2`.
     - Returns: Interpolated value.
     - Remark: This method performs the linear interpolation based on the following formula:
     ```
     ((1 - amount) * value1) + (value2 * amount)
     ```
     Passing `amount` a value of 0 will cause `value1` to be returned, a value of 1 will cause `value2` to be returned.
     This method does not have the floating point precision issuea that `lerp()` has.
     i.e. If there is a big gap between `value1` and `value2` in magnitude (e.g. `value1=10000000000000000, value2=1`),
     right at the edge of the interpolation range (`amount=1`), `lerp()` will return 0 (whereas it should return 1).
     This also holds for `value1=10^17, value2=10; value1=10^18, value2=10^2...` and so on.

     For an in depth explanation of the issue, see below references:

     [Relevant Wikipedia Article](https://en.wikipedia.org/wiki/Linear_interpolation#Programming_language_support)

     [Relevant StackOverflow Answer](http://stackoverflow.com/questions/4353525/floating-point-linear-interpolation#answer-23716956)
     */
    public static func lerpPrecise(_ value1: Float, _ value2: Float, amount: Float) -> Float {
        return ((1.0 - amount) * value1) + (value2 * amount)
    }

    /**
     Interpolates between two values using a cubic equation.

     - Parameters:
        - value1: Source value.
        - value2: Destination value.
        - amount: Weighting value.
     - Returns: Interpolated value.
     */
    public static func smoothStep(_ value1: Float, _ value2: Float, amount: Float) -> Float {
        // It is expected that 0 < amount < 1./
        // If amount < 0, return value1.
        // If amount > 1, return value2.
        var result = clamp(amount, min: 0, max: 1)
        result = hermite(value1, tangent1: 0, value2, tangent2: 0, amount: result)

        return result
    }

    /**
     Reduces a given angle to a value between π and -π.

     - Parameter angle: The angle to reduce, in radians.
     - Returns: The new angle, in radians.
     */
    public static func wrapAngle(_ angle: Float) -> Float {
        if (angle > -pi) && (angle <= pi) {
            return angle
        }
        let angle = angle.truncatingRemainder(dividingBy: twoPi)
        if angle <= -pi {
            return angle + twoPi
        }
        if angle > pi {
            return angle - twoPi
        }
        return angle
    }
}

public extension Float {
    /**
     Converts radians to degrees.
     - Remark: This method uses double precision internally, though it returns a single float.
     */
    func toDegrees() -> Float {
        return Float(Float64(self) * (180 / Float64.pi))
    }

    /**
     Converts degrees to radians.
     - Remark: This method uses double precision internally, though it returns a single float.
     */
    func roRadians() -> Float {
        return Float(Float64(self) * (Float64.pi / 180))
    }
}

public extension FixedWidthInteger {
    /**
     Determines if the value is a power of two.
     - Returns: `true` if the number is a power of two; otherwise `false`.
     */
    var isPowerOfTwo: Bool {
        return (self > 0) && ((self & (self - 1)) == 0)
    }
}
