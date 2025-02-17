import XCTest
@testable import MVC

final class AppCoordinatorTests: XCTestCase {
    var coordinator: MockAppCoordinator!
    
    override func setUp() {
        super.setUp()
        coordinator = MockAppCoordinator()
    }
    
    override func tearDown() {
        super.tearDown()
        coordinator = nil
    }
    
    func testStartPhotosViewController() {
        // When
        coordinator.start()
        
        // Then
        XCTAssertTrue(coordinator.didStartPhotosCoordinator)
    }
}
