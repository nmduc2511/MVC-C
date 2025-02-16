import XCTest
@testable import MVC

final class AppCoordinatorTests: XCTestCase {
    var coordinator: AppCoordinator!
    var navigation: UINavigationController!
    
    override func setUp() {
        super.setUp()
        navigation = UINavigationController()
        coordinator = AppCoordinator(
            navigationController: navigation)
    }
    
    override func tearDown() {
        super.tearDown()
        coordinator = nil
        navigation = nil
    }
    
    func testStartPhotosViewController() {
        coordinator.start()
        
        XCTAssertTrue(navigation.viewControllers.first is PhotosViewController)
    }
}
