import XCTest
@testable import ListViewController

final class ListViewControllerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ListViewController().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
