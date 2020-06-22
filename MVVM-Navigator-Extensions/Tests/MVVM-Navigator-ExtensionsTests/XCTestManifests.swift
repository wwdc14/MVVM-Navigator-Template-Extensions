import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MVVM_Navigator_ExtensionsTests.allTests),
    ]
}
#endif
