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

    func testCeil() {
        // Test positive rounding
        var vector = Vector3(1.999)
        XCTAssertEqual(vector.ceiling, Vector3(2.0))

        // Test .0 non-rounding
        vector = Vector3(2.0)
        XCTAssertEqual(vector.ceiling, Vector3(2.0))

        // Test negative rounding
        vector = Vector3(-3.499)
        XCTAssertEqual(vector.ceiling, Vector3(-3.0))
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

    static var allTests = [
        ("testDistanceSquared", testDistanceSquared),
        ("testInitializers", testInitializers),
        ("testMultiplication", testMultiplication),
        ("testCeil", testCeil),
        ("testDebugStrings", testDebugStrings),
        ("testConstants", testConstants),
        ("testClamping", testClamping),
        ("testCrossProduct", testCrossProduct),
    ]
}
