//
//  Vector2Tests.swift
//  
//
//  Created by David Green on 10/9/20.
//

import XCTest
@testable import SwiftGame

final class Vector2Tests: XCTestCase {
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

    func testCeil() {
        // Test positive rounding
        var vector = Vector2(1.999)
        XCTAssertEqual(vector.ceiling, Vector2(2.0))

        // Test .0 non-rounding
        vector = Vector2(2.0)
        XCTAssertEqual(vector.ceiling, Vector2(2.0))

        // Test negative rounding
        vector = Vector2(-3.499)
        XCTAssertEqual(vector.ceiling, Vector2(-3.0))
    }

    static var allTests = [
        ("testMultiplication", testMultiplication),
        ("testCeil", testCeil),
    ]
}
