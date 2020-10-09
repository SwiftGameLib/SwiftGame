import XCTest

import SwiftGameTests

var tests = [XCTestCaseEntry]()
tests += MathHelperTests.allTests()
tests += Vector2Tests.allTests()
tests += Vector3Tests.allTests()
tests += Vector4Tests.allTests()
XCTMain(tests)
