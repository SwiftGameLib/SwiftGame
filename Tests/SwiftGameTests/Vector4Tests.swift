//
//  Vector4Tests.swift
//
//
//  Created by David Green on 10/9/20.
//

import XCTest
@testable import SwiftGame

final class Vector4Tests: XCTestCase {
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

    static var allTests = [
        ("testMultiplication", testMultiplication),
    ]
}
