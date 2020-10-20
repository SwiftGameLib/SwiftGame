//
//  Vector4Tests.swift
//
//
//  Created by David Green on 10/9/20.
//

import XCTest
@testable import SwiftGame

final class Vector4Tests: XCTestCase {

    func testInitializers () {
        let expectedResult = Vector4(1, 2, 3, 4)
        let expectedResult2 = Vector4(2.2, 2.2, 2.2, 2.2)

        XCTAssertEqual(expectedResult, Vector4(1, 2, 3, 4))
        XCTAssertEqual(expectedResult, Vector4(Vector2(1, 2), 3, 4))
        XCTAssertEqual(expectedResult, Vector4(Vector3(1, 2, 3), 4))
        XCTAssertEqual(expectedResult2, Vector4(2.2))
    }

    func testMultiplication() {
        let vector = Vector4(1, 2, 3, 4)

        // Test 0.0 scale
        XCTAssertEqual(Vector4.zero, 0 * vector)
        XCTAssertEqual(Vector4.zero, vector * 0)

        // Test 1.0 scale
        XCTAssertEqual(vector, 1 * vector)
        XCTAssertEqual(vector, vector * 1)

        var scaledVec = Vector4(vector.x * 2, vector.y * 2, vector.z * 2, vector.w * 2)

        // Test 2.0 scale
        XCTAssertEqual(scaledVec, 2 * vector)
        XCTAssertEqual(scaledVec, vector * 2)
        XCTAssertEqual(vector * 2, scaledVec)

        scaledVec = Vector4(vector.x * 0.999, vector.y * 0.999, vector.z * 0.999, vector.w * 0.999)

        // Test 0.999 scale
        XCTAssertEqual(scaledVec, 0.999 * vector)
        XCTAssertEqual(scaledVec, vector * 0.999)
        XCTAssertEqual(vector * 0.999, scaledVec)

        let vector2 = Vector4(2, 2, 2, 2)

        // Test vector multiplication
        XCTAssertEqual(Vector4(vector.x * vector2.x, vector.y * vector2.y, vector.z * vector2.z, vector.w * vector2.w), vector * vector2)
        XCTAssertEqual(vector2 * vector, Vector4(vector.x * vector2.x, vector.y * vector2.y, vector.z * vector2.z, vector.w * vector2.w))
        XCTAssertEqual(vector * vector2, vector2 * vector)
    }

    func testRounding() {
        // MARK: Ceiling
        // Test positive rounding
        var vector = Vector4(1.999)
        XCTAssertEqual(vector.ceiling, Vector4(2.0))

        // Test .0 non-rounding
        vector = Vector4(2.0)
        XCTAssertEqual(vector.ceiling, Vector4(2.0))

        // Test negative rounding
        vector = Vector4(-3.499)
        XCTAssertEqual(vector.ceiling, Vector4(-3.0))
        
        // MARK: Floor
        // Test positive rounding
        vector = Vector4(1.999)
        XCTAssertEqual(vector.floor, Vector4(1.0))

        // Test .0 non-rounding
        vector = Vector4(2.0)
        XCTAssertEqual(vector.floor, Vector4(2.0))

        // Test negative rounding
        vector = Vector4(-3.499)
        XCTAssertEqual(vector.floor, Vector4(-4.0))
    }

    func testDebugStrings() {
        let vector = Vector4(2.2)

        XCTAssertEqual(vector.debugDescription, "2.2 2.2 2.2 2.2")
    }

    func testConstants() {
        XCTAssertEqual(Vector4.zero, Vector4(0, 0, 0, 0))
        XCTAssertEqual(Vector4.one, Vector4(1, 1, 1, 1))
        XCTAssertEqual(Vector4.unitX, Vector4(1, 0, 0, 0))
        XCTAssertEqual(Vector4.unitY, Vector4(0, 1, 0, 0))
        XCTAssertEqual(Vector4.unitZ, Vector4(0, 0, 1, 0))
        XCTAssertEqual(Vector4.unitW, Vector4(0, 0, 0, 1))
    }

    func testClamping() {
        let testVector = Vector4(5, 7, 9, 11)
        XCTAssertEqual(testVector.clamped(between: Vector4(6, 8, 8, 8), and: Vector4(8, 10, 8.5, 10)), Vector4(6, 8, 8.5, 10))
    }

    func testDistanceSquared() {
        let v1 = Vector4(0.1, 100.0, -5.5, 5.0)
        let v2 = Vector4(1.1, -2.0, 5.5, 0.0)
        let d = Vector4.distanceSquared(v1, v2)
        XCTAssertEqual(d, 10551)
    }
    
    func testDot() {
        let vector1 = Vector4(1, 2, 3, 4)
        let vector2 = Vector4(0.5, 1.1, -3.8, 1.2)
        
        let expectedResult: Float = -3.89999962
        
        XCTAssertEqual(expectedResult, Vector4.dot(vector1, vector2))
        
        var result: Float = 0.0
        Vector4.dot(vector1, vector2, result: &result)
        XCTAssertEqual(expectedResult, result)
    }

    func testHash() {
        // Check for overflows
        let max = Vector4(Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude,
                          Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude)
        let min = Vector4(Float.leastNormalMagnitude, Float.leastNormalMagnitude,
                          Float.leastNormalMagnitude, Float.leastNormalMagnitude)
        
        XCTAssertNotEqual(max.hashValue, Vector4.zero.hashValue)
        XCTAssertNotEqual(min.hashValue, Vector4.zero.hashValue)
        
        // Common values
        let a = Vector4(0)
        XCTAssertEqual(a.hashValue, Vector4.zero.hashValue)
        XCTAssertNotEqual(a.hashValue, Vector4.one.hashValue)
        
        // Individual properties
        let xa = Vector4(2, 1, 1, 1)
        let xb = Vector4(3, 1, 1, 1)
        let ya = Vector4(1, 2, 1, 1)
        let yb = Vector4(1, 3, 1, 1)
        let za = Vector4(1, 1, 2, 1)
        let zb = Vector4(1, 1, 3, 1)
        let wa = Vector4(1, 1, 1, 2)
        let wb = Vector4(1, 1, 1, 3)
        
        XCTAssertNotEqual(xa.hashValue, xb.hashValue)
        XCTAssertNotEqual(ya.hashValue, yb.hashValue)
        XCTAssertNotEqual(za.hashValue, zb.hashValue)
        XCTAssertNotEqual(wa.hashValue, wb.hashValue)
        
        XCTAssertNotEqual(xa.hashValue, ya.hashValue)
        XCTAssertNotEqual(xb.hashValue, yb.hashValue)
        XCTAssertNotEqual(xb.hashValue, zb.hashValue)
        XCTAssertNotEqual(yb.hashValue, zb.hashValue)
        XCTAssertNotEqual(xb.hashValue, wb.hashValue)
        XCTAssertNotEqual(yb.hashValue, wb.hashValue)
        
        XCTAssertNotEqual(xa.hashValue, yb.hashValue)
        XCTAssertNotEqual(ya.hashValue, xb.hashValue)
        XCTAssertNotEqual(xa.hashValue, zb.hashValue)
        XCTAssertNotEqual(xa.hashValue, wb.hashValue)
    }
    
    func testHermite() {
        let t1 = Vector4(1.40625, 1.40625, 1.40625, 1.40625)
        let t2 = Vector4(2.662375, 2.26537514, 2.662375, 2.26537514)
        
        let v1 = Vector4(1, 1, 1, 1), v2 = Vector4(2, 2, 2, 2), v3 = Vector4(3, 3, 3, 3), v4 = Vector4(4, 4, 4, 4)
        let v5 = Vector4(4, 3, 4, 3), v6 = Vector4(2, 1, 2, 1), v7 = Vector4(1, 2, 1, 2), v8 = Vector4(3, 4, 3, 4)
        
        XCTAssertEqual(t1, Vector4.hermite(v1, tangent1: v2, v3, tangent2: v4, amount: 0.25))
        XCTAssertEqual(t2, Vector4.hermite(v5, tangent1: v6, v7, tangent2: v8, amount: 0.45))
        
        var result1 = Vector4(0)
        var result2 = Vector4(0)
        
        Vector4.hermite(v1, tangent1: v2, v3, tangent2: v4, amount: 0.25, result: &result1)
        Vector4.hermite(v5, tangent1: v6, v7, tangent2: v8, amount: 0.45, result: &result2)
        
        XCTAssertEqual(t1, result1)
        XCTAssertEqual(t2, result2)
    }

    func testLength() {
        let vector1 = Vector4(1, 2, 3, 4)
        XCTAssertEqual(vector1.length, 5.477226)
    }
    
    func testLengthSquared() {
        let vector1 = Vector4(1, 2, 3, 4)
        XCTAssertEqual(vector1.lengthSquared, 30)
    }
    
    func testLerp() {
        let vector1 = Vector4(1, 2, 3, 4)
        let vector2 = Vector4(4, 3, 2, 1)
        
        XCTAssertEqual(Vector4.lerp(vector1, vector2, amount: 0.5), Vector4(2.5, 2.5, 2.5, 2.5))
        
        let vector3 = Vector4(1.0e20, 2, 3, 4)
        
        XCTAssertEqual(Vector4.lerp(vector3, vector1, amount: 1.0), Vector4(0.0, 2, 3, 4))
    }
    
    func testPreciseLerp() {
        let vector1 = Vector4(1, 2, 3, 4)
        let vector2 = Vector4(4, 3, 2, 1)
        
        XCTAssertEqual(Vector4.lerpPrecise(vector1, vector2, amount: 0.5), Vector4(2.5, 2.5, 2.5, 2.5))
        
        let vector3 = Vector4(1.0e20, 2, 3, 4)
        
        XCTAssertEqual(Vector4.lerpPrecise(vector3, vector1, amount: 1.0), Vector4(1.0, 2, 3, 4))
    }
    
    func testMinMax() {
        XCTAssertEqual(
            Vector4.max(
                Vector4(1, 2, 3, 4),
                Vector4(4, 3, 2, 1)),
            Vector4(4, 3, 3, 4))
        
        XCTAssertEqual(
            Vector4.max(
                Vector4(-1, -2, -3, -4),
                Vector4(-4, -3, -2, -1)),
            Vector4(-1, -2, -2, -1))
        
        XCTAssertEqual(
            Vector4.min(
                Vector4(1, 2, 3, 4),
                Vector4(4, 3, 2, 1)),
            Vector4(1, 2, 2, 1))
        
        XCTAssertEqual(
            Vector4.min(
                Vector4(-1, -2, -3, -4),
                Vector4(-4, -3, -2, -1)),
            Vector4(-4, -3, -3, -4))
    }
    
    func testNormalize() {
        let vector1 = Vector4(1, 2, 3, 4)
        XCTAssertEqual(vector1.normalized.x, 0.18257418)
        XCTAssertEqual(vector1.normalized.y, 0.36514837)
        XCTAssertEqual(vector1.normalized.z, 0.5477226)
        XCTAssertEqual(vector1.normalized.w, 0.73029673)
    }

    static var allTests = [
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
