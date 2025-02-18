import XCTest
@testable import MVC

// test_NavigationMethod_ShouldNavigateToExpectedScreen()

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
    
    func test_Start_ShouldInitializeRootViewController() {
        // Act
        coordinator.start()
        
        // Assert
        XCTAssertTrue(coordinator.didStartPhotosCoordinator)
    }
}
