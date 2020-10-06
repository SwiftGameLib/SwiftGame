//
//  File.swift
//  
//
//  Created by David Green on 10/5/20.
//

import XCTest
@testable import SwiftGame

final class MathHelperTests: XCTestCase {
    func testClampFloat() {
        XCTAssertEqual(MathHelper.clamp(1.0, min: 0.0, max: 2.0), 1.0, "Failed boundary test, clamp [0,2] on 1 should be 1")
        XCTAssertEqual(MathHelper.clamp(1.0, min: 0.0, max: 1.0), 1.0, "Failed boundary test, clamp [0,1] on 1 should be 1")
        XCTAssertEqual(MathHelper.clamp(1.0, min: 2.0, max: 5.0), 2.0, "Failed boundary test, clamp [2,5] on 1 should be 2")
        XCTAssertEqual(MathHelper.clamp(1.0, min: -50.0, max: -10.0), -10.0, "Failed boundary test, clamp [-50,-10] on 1 should be -10")
        XCTAssertEqual(MathHelper.clamp(1.0, min: -50.0, max: 25.0), 1.0, "Failed boundary test, clamp [-50,25] on 1 should be 1")
        XCTAssertEqual(MathHelper.clamp(0.0, min: 1.0, max: 1.0), 1.0, "Failed boundary test, clamp [1,1] on 0 should be 1")
        XCTAssertEqual(MathHelper.clamp(0.0, min: -1.0, max: -1.0), -1.0, "Failed boundary test, clamp [-1,-1] on 0 should be -1")
    }

    func testClampInt() {
        XCTAssertEqual(MathHelper.clamp(1, min: 0, max: 2), Int(1), "Failed boundary test, clamp [0,2] on 1 should be 1")
        XCTAssertEqual(MathHelper.clamp(1, min: 0, max: 1), Int(1), "Failed boundary test, clamp [0,1] on 1 should be 1")
        XCTAssertEqual(MathHelper.clamp(1, min: 2, max: 5), Int(2), "Failed boundary test, clamp [2,5] on 1 should be 2")
        XCTAssertEqual(MathHelper.clamp(1, min: -50, max: -10), Int(-10), "Failed boundary test, clamp [-50,-10] on 1 should be -10")
        XCTAssertEqual(MathHelper.clamp(1, min: -50, max: 25), Int(1), "Failed boundary test, clamp [-50,25] on 1 should be 1")
        XCTAssertEqual(MathHelper.clamp(0, min: 1, max: 1), Int(1), "Failed boundary test, clamp [1,1] on 0 should be 1")
        XCTAssertEqual(MathHelper.clamp(0, min: -1, max: -1), Int(-1), "Failed boundary test, clamp [-1,-1] on 0 should be -1")
    }

    func testDistance() {
        XCTAssertEqual(MathHelper.distance(0.0, 5.0), 5.0, "Distance test failed on [0,5]")
        XCTAssertEqual(MathHelper.distance(-5.0, 5.0), 10.0, "Distance test failed on [-5,5]")
        XCTAssertEqual(MathHelper.distance(0.0, 0.0), 0.0, "Distance test failed on [0,0]")
        XCTAssertEqual(MathHelper.distance(-5.0, -1.0), 4.0, "Distance test failed on [-5,-1]")

    }

    func testLerp() {
        XCTAssertEqual(MathHelper.lerp(0.0, 5.0, amount: 0.5), 2.5, "Lerp test failed on [0,5,0.5]")
        XCTAssertEqual(MathHelper.lerp(-5.0, 5.0, amount: 0.5), 0.0, "Lerp test failed on [-5,5,0.5]")
        XCTAssertEqual(MathHelper.lerp(0.0, 0.0, amount: 0.5), 0.0, "Lerp test failed on [0,0,0.5]")
        XCTAssertEqual(MathHelper.lerp(-5.0, -1.0, amount: 0.5), -3.0, "Lerp test failed on [-5,-1,0.5]")
        // Test the imprecise version has issues
        XCTAssertEqual(MathHelper.lerp(10000000000000000.0, 1.0, amount: 1.0), 0.0, "Lerp test failed on [10000000000000000.0,1.0,1.0]")
    }

    func testPreciseLerp() {
        XCTAssertEqual(MathHelper.lerpPrecise(0.0, 5.0, amount: 0.5), 2.5, "Lerp test failed on [0,5,0.5]")
        XCTAssertEqual(MathHelper.lerpPrecise(-5.0, 5.0, amount: 0.5), 0.0, "Lerp test failed on [-5,5,0.5]")
        XCTAssertEqual(MathHelper.lerpPrecise(0.0, 0.0, amount: 0.5), 0.0, "Lerp test failed on [0,0,0.5]")
        XCTAssertEqual(MathHelper.lerpPrecise(-5.0, -1.0, amount: 0.5), -3.0, "Lerp test failed on [-5,-1,0.5]")
        // Test the imprecise version has issues
        XCTAssertEqual(MathHelper.lerpPrecise(10000000000000000.0, 1.0, amount: 1.0), 1.0, "Lerp test failed on [10000000000000000.0,1.0,1.0]")
    }

    func testPiConstants() {

        XCTAssertEqual(MathHelper.piOver4, 0.7853982)
        XCTAssertEqual(MathHelper.piOver2, 1.5707964)
        XCTAssertEqual(MathHelper.pi, 3.1415927)
        XCTAssertEqual(MathHelper.twoPi, 6.2831855)
    }

    func testWrapAngle() {
        XCTAssertEqual(MathHelper.wrapAngle(0.0), 0.0)
        XCTAssertEqual(MathHelper.wrapAngle(MathHelper.piOver4), MathHelper.piOver4)
        XCTAssertEqual(MathHelper.wrapAngle(-MathHelper.piOver4), -MathHelper.piOver4)
        XCTAssertEqual(MathHelper.wrapAngle(MathHelper.piOver2), MathHelper.piOver2)
        XCTAssertEqual(MathHelper.wrapAngle(-MathHelper.piOver2), -MathHelper.piOver2)
        XCTAssertEqual(MathHelper.wrapAngle(MathHelper.pi), MathHelper.pi)
        XCTAssertEqual(MathHelper.wrapAngle(-MathHelper.pi), MathHelper.pi)
        XCTAssertEqual(MathHelper.wrapAngle(MathHelper.twoPi), 0.0)
        XCTAssertEqual(MathHelper.wrapAngle(-MathHelper.twoPi), 0.0)
        XCTAssertEqual(MathHelper.wrapAngle(10.0), -2.566371)
        XCTAssertEqual(MathHelper.wrapAngle(-10.0), 2.566371)
        // Pi boundaries
        XCTAssertEqual(MathHelper.wrapAngle(3.1415927), 3.1415927)
        XCTAssertEqual(MathHelper.wrapAngle(3.141593), -3.1415925)
        XCTAssertEqual(MathHelper.wrapAngle(-3.1415925), -3.1415925)
        XCTAssertEqual(MathHelper.wrapAngle(-3.1415927), 3.1415927)
        // 2 * Pi boundaries
        XCTAssertEqual(MathHelper.wrapAngle(6.283185), -4.7683716E-7)
        XCTAssertEqual(MathHelper.wrapAngle(6.2831855), 0.0)
        XCTAssertEqual(MathHelper.wrapAngle(6.283186), 4.7683716E-7)
        XCTAssertEqual(MathHelper.wrapAngle(-6.283185), 4.7683716E-7)
        XCTAssertEqual(MathHelper.wrapAngle(-6.2831855), 0)
        XCTAssertEqual(MathHelper.wrapAngle(-6.283186), -4.7683716E-7)
        // 3 * Pi boundaries
        XCTAssertEqual(MathHelper.wrapAngle(9.424778), 3.1415925)
        XCTAssertEqual(MathHelper.wrapAngle(9.424779), -3.141592)
        XCTAssertEqual(MathHelper.wrapAngle(-9.424778), -3.1415925)
        XCTAssertEqual(MathHelper.wrapAngle(-9.424779), 3.141592)
        // 4 * Pi boundaries
        XCTAssertEqual(MathHelper.wrapAngle(12.56637), -9.536743E-7)
        XCTAssertEqual(MathHelper.wrapAngle(12.566371), 0.0)
        XCTAssertEqual(MathHelper.wrapAngle(12.566372), 9.536743E-7)
        XCTAssertEqual(MathHelper.wrapAngle(-12.56637), 9.536743E-7)
        XCTAssertEqual(MathHelper.wrapAngle(-12.566371), 0.0)
        XCTAssertEqual(MathHelper.wrapAngle(-12.566372), -9.536743E-7)
        // 5 * Pi boundaries
        XCTAssertEqual(MathHelper.wrapAngle(15.707963), 3.141592)
        XCTAssertEqual(MathHelper.wrapAngle(15.707964), -3.1415925)
        XCTAssertEqual(MathHelper.wrapAngle(-15.707963), -3.141592)
        XCTAssertEqual(MathHelper.wrapAngle(-15.707964), 3.1415925)
        // 10 * Pi boundaries
        XCTAssertEqual(MathHelper.wrapAngle(31.415926), -1.4305115E-6)
        XCTAssertEqual(MathHelper.wrapAngle(31.415928), 4.7683716E-7)
        XCTAssertEqual(MathHelper.wrapAngle(-31.415926), 1.4305115E-6)
        XCTAssertEqual(MathHelper.wrapAngle(-31.415928), -4.7683716E-7)
        // 20 * Pi boundaries
        XCTAssertEqual(MathHelper.wrapAngle(62.831852), -2.861023E-6)
        XCTAssertEqual(MathHelper.wrapAngle(62.831856), 9.536743E-7)
        XCTAssertEqual(MathHelper.wrapAngle(-62.831852), 2.861023E-6)
        XCTAssertEqual(MathHelper.wrapAngle(-62.831856), -9.536743E-7)
        // 20000000 * Pi boundaries
        XCTAssertEqual(MathHelper.wrapAngle(6.2831852E7), -2.8202515)
        XCTAssertEqual(MathHelper.wrapAngle(6.2831856E7), 1.1797485)
        XCTAssertEqual(MathHelper.wrapAngle(-6.2831852E7), 2.8202515)
        XCTAssertEqual(MathHelper.wrapAngle(-6.2831856E7), -1.1797485)
    }

    static var allTests = [
        ("testClampFloat", testClampFloat),
        ("testClampInt", testClampInt),
        ("testDistance", testDistance),
        ("testLerp", testLerp),
        ("testPreciseLerp", testPreciseLerp),
        ("testPiConstants", testPiConstants),
        ("testWrapAngle", testWrapAngle),
    ]
}
