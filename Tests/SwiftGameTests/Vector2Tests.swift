//
//  Vector2Tests.swift
//  
//
//  Created by David Green on 10/9/20.
//

import XCTest
@testable import SwiftGame

final class Vector2Tests: XCTestCase {

    func testInitializers () {
        let expectedResult = Vector2(1,2)
        let expectedResult2 = Vector2(2.2, 2.2)

        XCTAssertEqual(expectedResult, Vector2(1, 2))
        XCTAssertEqual(expectedResult2, Vector2(2.2))
    }

    func testMultiplication() {
        let vector = Vector2(1, 2)

        // Test 0.0 scale
        XCTAssertEqual(Vector2.zero, 0 * vector)
        XCTAssertEqual(Vector2.zero, vector * 0)

        // Test 1.0 scale
        XCTAssertEqual(vector, 1 * vector)
        XCTAssertEqual(vector, vector * 1)

        var scaledVec = Vector2(vector.x * 2, vector.y * 2)

        // Test 2.0 scale
        XCTAssertEqual(scaledVec, 2 * vector)
        XCTAssertEqual(scaledVec, vector * 2)
        XCTAssertEqual(vector * 2, scaledVec)

        scaledVec = Vector2(vector.x * 0.999, vector.y * 0.999)

        // Test 0.999 scale
        XCTAssertEqual(scaledVec, 0.999 * vector)
        XCTAssertEqual(scaledVec, vector * 0.999)
        XCTAssertEqual(vector * 0.999, scaledVec)

        let vector2 = Vector2(2, 2)

        // Test vector multiplication
        XCTAssertEqual(Vector2(vector.x * vector2.x, vector.y * vector2.y), vector * vector2)
        XCTAssertEqual(vector2 * vector, Vector2(vector.x * vector2.x, vector.y * vector2.y))
        XCTAssertEqual(vector * vector2, vector2 * vector)
    }

    func testRounding() {
        // MARK: ceiling
        // Test positive rounding
        var vector = Vector2(1.999)
        XCTAssertEqual(vector.ceiling, Vector2(2.0))

        // Test .0 non-rounding
        vector = Vector2(2.0)
        XCTAssertEqual(vector.ceiling, Vector2(2.0))

        // Test negative rounding
        vector = Vector2(-3.499)
        XCTAssertEqual(vector.ceiling, Vector2(-3.0))
        
        // MARK: Floor
        // Test positive rounding
        vector = Vector2(1.999)
        XCTAssertEqual(vector.floor, Vector2(1.0))

        // Test .0 non-rounding
        vector = Vector2(2.0)
        XCTAssertEqual(vector.floor, Vector2(2.0))

        // Test negative rounding
        vector = Vector2(-3.499)
        XCTAssertEqual(vector.floor, Vector2(-4.0))
        
        // MARK: Rounded
        vector = Vector2(1.499, 2.5)
        XCTAssertEqual(vector.rounded, Vector2(1.0, 3.0))
    }

    func testDebugStrings() {
        let vector = Vector2(2.2)

        XCTAssertEqual(vector.debugDescription, "2.2 2.2")
    }

    func testConstants() {
        XCTAssertEqual(Vector2.zero, Vector2(0, 0))
        XCTAssertEqual(Vector2.one, Vector2(1, 1))
        XCTAssertEqual(Vector2.unitX, Vector2(1, 0))
        XCTAssertEqual(Vector2.unitY, Vector2(0, 1))
    }

    func testClamping() {
        let testVector = Vector2(5, 7)
        XCTAssertEqual(testVector.clamped(between: Vector2(6, 8), and: Vector2(8, 10)), Vector2(6, 8))
    }

    func testDistanceSquared() {
        let v1 = Vector2(0.1, 100.0)
        let v2 = Vector2(1.1, -2.0)
        let d = Vector2.distanceSquared(v1, v2)
        XCTAssertEqual(d, 10405)
    }

    func testDot() {
        let vector1 = Vector2(1, 2)
        let vector2 = Vector2(0.5, 1.1)
        
        let expectedResult: Float = 2.7
        
        XCTAssertEqual(expectedResult, Vector2.dot(vector1, vector2))
        
        var result: Float = 0.0
        Vector2.dot(vector1, vector2, result: &result)
        XCTAssertEqual(expectedResult, result)
    }
    
    func testHash() {
        // Check for overflows
        let max = Vector2(Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude)
        let min = Vector2(Float.leastNormalMagnitude, Float.leastNormalMagnitude)
        
        XCTAssertNotEqual(max.hashValue, Vector2.zero.hashValue)
        XCTAssertNotEqual(min.hashValue, Vector2.zero.hashValue)
        
        // Common values
        let a = Vector2(0)
        XCTAssertEqual(a.hashValue, Vector2.zero.hashValue)
        XCTAssertNotEqual(a.hashValue, Vector2.one.hashValue)
        
        // Individual properties
        let xa = Vector2(2, 1)
        let xb = Vector2(3, 1)
        let ya = Vector2(1, 2)
        let yb = Vector2(1, 3)
        XCTAssertNotEqual(xa.hashValue, xb.hashValue)
        XCTAssertNotEqual(ya.hashValue, yb.hashValue)
        
        XCTAssertNotEqual(xa.hashValue, ya.hashValue)
        XCTAssertNotEqual(xb.hashValue, yb.hashValue)
        
        XCTAssertNotEqual(xa.hashValue, yb.hashValue)
        XCTAssertNotEqual(ya.hashValue, xb.hashValue)
    }
    
    func testHermite() {
        let t1 = Vector2(1.40625, 1.40625)
        let t2 = Vector2(2.662375, 2.26537514)
        
        let v1 = Vector2(1, 1), v2 = Vector2(2, 2), v3 = Vector2(3, 3), v4 = Vector2(4, 4)
        let v5 = Vector2(4, 3), v6 = Vector2(2, 1), v7 = Vector2(1, 2), v8 = Vector2(3, 4)
        
        XCTAssertEqual(t1, Vector2.hermite(v1, tangent1: v2, v3, tangent2: v4, amount: 0.25))
        XCTAssertEqual(t2, Vector2.hermite(v5, tangent1: v6, v7, tangent2: v8, amount: 0.45))
        
        var result1 = Vector2(0)
        var result2 = Vector2(0)
        
        Vector2.hermite(v1, tangent1: v2, v3, tangent2: v4, amount: 0.25, result: &result1)
        Vector2.hermite(v5, tangent1: v6, v7, tangent2: v8, amount: 0.45, result: &result2)
        
        XCTAssertEqual(t1, result1)
        XCTAssertEqual(t2, result2)
    }

    func testLength() {
        let vector1 = Vector2(3, 4)
        XCTAssertEqual(vector1.length, 5)
    }

    func testLengthSquared() {
        let vector1 = Vector2(1, 2)
        XCTAssertEqual(vector1.lengthSquared, 5)
    }

    func testLerp() {
        let vector1 = Vector2(1, 2)
        let vector2 = Vector2(4, 3)
        
        XCTAssertEqual(Vector2.lerp(vector1, vector2, amount: 0.5), Vector2(2.5, 2.5))
        
        let vector3 = Vector2(1.0e20, 2)
        
        XCTAssertEqual(Vector2.lerp(vector3, vector1, amount: 1.0), Vector2(0.0, 2))
    }
    
    func testPreciseLerp() {
        let vector1 = Vector2(1, 2)
        let vector2 = Vector2(4, 3)
        
        XCTAssertEqual(Vector2.lerpPrecise(vector1, vector2, amount: 0.5), Vector2(2.5, 2.5))
        
        let vector3 = Vector2(1.0e20, 2)
        
        XCTAssertEqual(Vector2.lerpPrecise(vector3, vector1, amount: 1.0), Vector2(1.0, 2))
    }

    func testMinMax() {
        XCTAssertEqual(
            Vector2.max(
                Vector2(1, 2),
                Vector2(4, 3)),
            Vector2(4, 3))
        
        XCTAssertEqual(
            Vector2.max(
                Vector2(-1, -2),
                Vector2(-4, -3)),
            Vector2(-1, -2))
        
        XCTAssertEqual(
            Vector2.min(
                Vector2(1, 2),
                Vector2(4, 3)),
            Vector2(1, 2))
        
        XCTAssertEqual(
            Vector2.min(
                Vector2(-1, -2),
                Vector2(-4, -3)),
            Vector2(-4, -3))
    }

    func testNormalize() {
        let vector1 = Vector2(1, 2)
        XCTAssertEqual(vector1.normalized.x, 0.4472136)
        XCTAssertEqual(vector1.normalized.y, 0.8944272)
    }

    func testSmoothStep() {
        let vector1 = Vector2(1, 2)
        let vector2 = Vector2(4, 3)
        
        XCTAssertEqual(Vector2.smoothStep(vector1, vector2, amount: 0.25),
                       Vector2(1.46875, 2.15625))
        XCTAssertEqual(Vector2.smoothStep(vector1, vector2, amount: 0.50),
                       Vector2(2.5, 2.5))
        XCTAssertEqual(Vector2.smoothStep(vector1, vector2, amount: 0.70),
                       Vector2(3.352, 2.784))
    }
    
    func testReflect() {
        let vector = Vector2(-1, -2)
        let normal = Vector2(0, 1)
        
        XCTAssertEqual(vector.reflect(by: normal), Vector2(-1, 2))
    }

    static var allTests = [
        ("testReflect", testReflect),
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
    ]
}
