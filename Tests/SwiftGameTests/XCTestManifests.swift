import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MathHelperTests.allTests),
        testCase(Vector2Tests.allTests),
    ]
}
#endif
