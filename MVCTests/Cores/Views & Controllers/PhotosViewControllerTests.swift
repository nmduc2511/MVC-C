import XCTest
@testable import MVC

class PhotosViewControllerTests: XCTestCase {
    var viewController: PhotosViewController!
    
    override func setUp() {
        super.setUp()
        viewController = PhotosViewController(
            photosMananger: PhotosMananger(
                repository: PhotosRepository()),
            coordinator: PhotosCoordinator(
                navigationController: UINavigationController()))
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
    }
    
    func test_ibOutlet() {
        _ = viewController.view
        XCTAssertNotNil(viewController.view)
        XCTAssertNotNil(viewController.tableView)
    }
    
    func test_dependencies() {
        XCTAssertNotNil(viewController.coordinator)
        XCTAssertNotNil(viewController.photosMananger)
    }
}
