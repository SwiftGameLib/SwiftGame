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

    func testCeil() {
        // Test positive rounding
        var vector = Vector4(1.999)
        XCTAssertEqual(vector.ceiling, Vector4(2.0))

        // Test .0 non-rounding
        vector = Vector4(2.0)
        XCTAssertEqual(vector.ceiling, Vector4(2.0))

        // Test negative rounding
        vector = Vector4(-3.499)
        XCTAssertEqual(vector.ceiling, Vector4(-3.0))
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

    static var allTests = [
        ("testDistanceSquared", testDistanceSquared),
        ("testInitializers", testInitializers),
        ("testMultiplication", testMultiplication),
        ("testCeil", testCeil),
        ("testDebugStrings", testDebugStrings),
        ("testConstants", testConstants),
        ("testClamping", testClamping),
    ]
}
