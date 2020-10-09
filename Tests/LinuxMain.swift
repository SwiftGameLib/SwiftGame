import XCTest

import SwiftGameTests

var tests = [XCTestCaseEntry]()
tests += MathHelperTests.allTests()
tests += Vector2Tests.allTests()
XCTMain(tests)
