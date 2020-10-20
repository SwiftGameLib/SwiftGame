//
//  Vector3Tests.swift
//
//
//  Created by David Green on 10/9/20.
//

import XCTest
@testable import SwiftGame

final class Vector3Tests: XCTestCase {

    func testInitializers () {
        let expectedResult = Vector3(1, 2, 3)
        let expectedResult2 = Vector3(2.2, 2.2, 2.2)

        XCTAssertEqual(expectedResult, Vector3(1, 2, 3))
        XCTAssertEqual(expectedResult, Vector3(Vector2(1, 2), 3))
        XCTAssertEqual(expectedResult2, Vector3(2.2))
    }

    func testMultiplication() {
        let vector = Vector3(1, 2, 3)

        // Test 0.0 scale
        XCTAssertEqual(Vector3.zero, 0 * vector)
        XCTAssertEqual(Vector3.zero, vector * 0)

        // Test 1.0 scale
        XCTAssertEqual(vector, 1 * vector)
        XCTAssertEqual(vector, vector * 1)

        var scaledVec = Vector3(vector.x * 2, vector.y * 2, vector.z * 2)

        // Test 2.0 scale
        XCTAssertEqual(scaledVec, 2 * vector)
        XCTAssertEqual(scaledVec, vector * 2)
        XCTAssertEqual(vector * 2, scaledVec)

        scaledVec = Vector3(vector.x * 0.999, vector.y * 0.999, vector.z * 0.999)

        // Test 0.999 scale
        XCTAssertEqual(scaledVec, 0.999 * vector)
        XCTAssertEqual(scaledVec, vector * 0.999)
        XCTAssertEqual(vector * 0.999, scaledVec)

        let vector2 = Vector3(2, 2, 2)

        // Test vector multiplication
        XCTAssertEqual(Vector3(vector.x * vector2.x, vector.y * vector2.y, vector.z * vector2.z), vector * vector2)
        XCTAssertEqual(vector2 * vector, Vector3(vector.x * vector2.x, vector.y * vector2.y, vector.z * vector2.z))
        XCTAssertEqual(vector * vector2, vector2 * vector)
    }

    func testRounding() {
        // MARK: Ceiling
        // Test positive rounding
        var vector = Vector3(1.999)
        XCTAssertEqual(vector.ceiling, Vector3(2.0))

        // Test .0 non-rounding
        vector = Vector3(2.0)
        XCTAssertEqual(vector.ceiling, Vector3(2.0))

        // Test negative rounding
        vector = Vector3(-3.499)
        XCTAssertEqual(vector.ceiling, Vector3(-3.0))
        
        // MARK: Floor
        // Test positive rounding
        vector = Vector3(1.999)
        XCTAssertEqual(vector.floor, Vector3(1.0))

        // Test .0 non-rounding
        vector = Vector3(2.0)
        XCTAssertEqual(vector.floor, Vector3(2.0))

        // Test negative rounding
        vector = Vector3(-3.499)
        XCTAssertEqual(vector.floor, Vector3(-4.0))
        
        // MARK: Rounded
        vector = Vector3(1.499, 2.5, 3.501)
        XCTAssertEqual(vector.rounded, Vector3(1.0, 3.0, 4.0))
    }

    func testDebugStrings() {
        let vector = Vector3(2.2)

        XCTAssertEqual(vector.debugDescription, "2.2 2.2 2.2")
    }

    func testConstants() {
        XCTAssertEqual(Vector3.zero, Vector3(0, 0, 0))
        XCTAssertEqual(Vector3.one, Vector3(1, 1, 1))
        XCTAssertEqual(Vector3.unitX, Vector3(1, 0, 0))
        XCTAssertEqual(Vector3.unitY, Vector3(0, 1, 0))
        XCTAssertEqual(Vector3.unitZ, Vector3(0, 0, 1))
        XCTAssertEqual(Vector3.up, Vector3(0, 1, 0))
        XCTAssertEqual(Vector3.down, Vector3(0, -1, 0))
        XCTAssertEqual(Vector3.left, Vector3(-1, 0, 0))
        XCTAssertEqual(Vector3.right, Vector3(1, 0, 0))
        XCTAssertEqual(Vector3.forward, Vector3(0, 0, -1))
        XCTAssertEqual(Vector3.backward, Vector3(0, 0, 1))
    }

    func testClamping() {
        let testVector = Vector3(5, 7, 9)
        XCTAssertEqual(testVector.clamped(between: Vector3(6, 8, 8), and: Vector3(8, 10, 8.5)), Vector3(6, 8, 8.5))
    }

    func testCrossProduct() {
        XCTAssertEqual(Vector3.cross(Vector3.forward, Vector3.left), Vector3.up)
    }

    func testDistanceSquared() {
        let v1 = Vector3(0.1, 100.0, -5.5)
        let v2 = Vector3(1.1, -2.0, 5.5)
        let d = Vector3.distanceSquared(v1, v2)
        XCTAssertEqual(d, 10526)
    }

    func testDot() {
        let vector1 = Vector3(1, 2, 3)
        let vector2 = Vector3(0.5, 1.1, -3.8)
        
        let expectedResult: Float = -8.7
        
        XCTAssertEqual(expectedResult, Vector3.dot(vector1, vector2))
        
        var result: Float = 0.0
        Vector3.dot(vector1, vector2, result: &result)
        XCTAssertEqual(expectedResult, result)
    }

    func testHash() {
        // Check for overflows
        let max = Vector3(Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude)
        let min = Vector3(Float.leastNormalMagnitude, Float.leastNormalMagnitude, Float.leastNormalMagnitude)
        
        XCTAssertNotEqual(max.hashValue, Vector3.zero.hashValue)
        XCTAssertNotEqual(min.hashValue, Vector3.zero.hashValue)
        
        // Common values
        let a = Vector3(0)
        XCTAssertEqual(a.hashValue, Vector3.zero.hashValue)
        XCTAssertNotEqual(a.hashValue, Vector3.one.hashValue)
        
        // Individual properties
        let xa = Vector3(2, 1, 1)
        let xb = Vector3(3, 1, 1)
        let ya = Vector3(1, 2, 1)
        let yb = Vector3(1, 3, 1)
        let za = Vector3(1, 1, 2)
        let zb = Vector3(1, 1, 3)
        
        XCTAssertNotEqual(xa.hashValue, xb.hashValue)
        XCTAssertNotEqual(ya.hashValue, yb.hashValue)
        XCTAssertNotEqual(za.hashValue, zb.hashValue)
        
        XCTAssertNotEqual(xa.hashValue, ya.hashValue)
        XCTAssertNotEqual(xb.hashValue, yb.hashValue)
        XCTAssertNotEqual(xb.hashValue, zb.hashValue)
        XCTAssertNotEqual(yb.hashValue, zb.hashValue)
        
        XCTAssertNotEqual(xa.hashValue, yb.hashValue)
        XCTAssertNotEqual(ya.hashValue, xb.hashValue)
        XCTAssertNotEqual(xa.hashValue, zb.hashValue)
    }
    
    func testHermite() {
        let t1 = Vector3(1.40625, 1.40625, 1.40625)
        let t2 = Vector3(2.662375, 2.26537514, 2.662375)
        
        let v1 = Vector3(1, 1, 1), v2 = Vector3(2, 2, 2), v3 = Vector3(3, 3, 3), v4 = Vector3(4, 4, 4)
        let v5 = Vector3(4, 3, 4), v6 = Vector3(2, 1, 2), v7 = Vector3(1, 2, 1), v8 = Vector3(3, 4, 3)
        
        XCTAssertEqual(t1, Vector3.hermite(v1, tangent1: v2, v3, tangent2: v4, amount: 0.25))
        XCTAssertEqual(t2, Vector3.hermite(v5, tangent1: v6, v7, tangent2: v8, amount: 0.45))
        
        var result1 = Vector3(0)
        var result2 = Vector3(0)
        
        Vector3.hermite(v1, tangent1: v2, v3, tangent2: v4, amount: 0.25, result: &result1)
        Vector3.hermite(v5, tangent1: v6, v7, tangent2: v8, amount: 0.45, result: &result2)
        
        XCTAssertEqual(t1, result1)
        XCTAssertEqual(t2, result2)
    }

    func testLength() {
        let vector1 = Vector3(1, 2, 3)
        XCTAssertEqual(vector1.length, 3.7416575)
    }

    func testLengthSquared() {
        let vector1 = Vector3(1, 2, 3)
        XCTAssertEqual(vector1.lengthSquared, 14)
    }

    func testLerp() {
        let vector1 = Vector3(1, 2, 3)
        let vector2 = Vector3(4, 3, 2)
        
        XCTAssertEqual(Vector3.lerp(vector1, vector2, amount: 0.5), Vector3(2.5, 2.5, 2.5))
        
        let vector3 = Vector3(1.0e20, 2, 3)
        
        XCTAssertEqual(Vector3.lerp(vector3, vector1, amount: 1.0), Vector3(0.0, 2, 3))
    }
    
    func testPreciseLerp() {
        let vector1 = Vector3(1, 2, 3)
        let vector2 = Vector3(4, 3, 2)
        
        XCTAssertEqual(Vector3.lerpPrecise(vector1, vector2, amount: 0.5), Vector3(2.5, 2.5, 2.5))
        
        let vector3 = Vector3(1.0e20, 2, 3)
        
        XCTAssertEqual(Vector3.lerpPrecise(vector3, vector1, amount: 1.0), Vector3(1.0, 2, 3))
    }

    func testMinMax() {
        XCTAssertEqual(
            Vector3.max(
                Vector3(1, 2, 3),
                Vector3(4, 3, 2)),
            Vector3(4, 3, 3))
        
        XCTAssertEqual(
            Vector3.max(
                Vector3(-1, -2, -3),
                Vector3(-4, -3, -2)),
            Vector3(-1, -2, -2))
        
        XCTAssertEqual(
            Vector3.min(
                Vector3(1, 2, 3),
                Vector3(4, 3, 2)),
            Vector3(1, 2, 2))
        
        XCTAssertEqual(
            Vector3.min(
                Vector3(-1, -2, -3),
                Vector3(-4, -3, -2)),
            Vector3(-4, -3, -3))
    }

    func testNormalize() {
        let vector1 = Vector3(1, 2, 3)
        XCTAssertEqual(vector1.normalized.x, 0.26726124)
        XCTAssertEqual(vector1.normalized.y, 0.5345225)
        XCTAssertEqual(vector1.normalized.z, 0.8017837)
    }

    func testSmoothStep() {
        let vector1 = Vector3(1, 2, 3)
        let vector2 = Vector3(4, 3, 2)
        
        XCTAssertEqual(Vector3.smoothStep(vector1, vector2, amount: 0.25),
                       Vector3(1.46875, 2.15625, 2.84375))
        XCTAssertEqual(Vector3.smoothStep(vector1, vector2, amount: 0.50),
                       Vector3(2.5, 2.5, 2.5))
        XCTAssertEqual(Vector3.smoothStep(vector1, vector2, amount: 0.70),
                       Vector3(3.352, 2.784, 2.216))
    }

    static var allTests = [
        ("testSmoothStep", testSmoothStep),
        ("testNormalize", testNormalize),
        ("testMinMax", testMinMax),
        ("testPreciseLerp", testPreciseLerp),
        ("testLerp", testLerp),
        ("testLengthSquared", testLengthSquared),
        ("testLength", testLength),
        ("testHermite", testHermite),
        ("testHash", testHash),
        ("testDot", testDot),
        ("testDistanceSquared", testDistanceSquared),
        ("testInitializers", testInitializers),
        ("testMultiplication", testMultiplication),
        ("testRounding", testRounding),
        ("testDebugStrings", testDebugStrings),
        ("testConstants", testConstants),
        ("testClamping", testClamping),
        ("testCrossProduct", testCrossProduct),
    ]
}
