import XCTest
@testable import MVC

class PhotosViewControllerTests: XCTestCase {
    var viewController: PhotosViewController!
    
    override func setUp() {
        super.setUp()
        let repository = MockPhotosRepository()
        let manager = PhotosManager(repository: repository)
//        let coodinator =
        viewController = PhotosViewController(
            photosMananger: manager,
            coordinator: Coordinator)
        viewController = PhotosViewController(
            photosMananger: PhotosManager(
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
    
    func testDependencies() {
        XCTAssertNotNil(viewController.coordinator)
        XCTAssertNotNil(viewController.photosMananger)
    }
    
    func testPhotosDisplaying() {
        // setup
        let repository = MockPhotosRepository()
        repository.data = [
            PhotoEntity(albumId: 1, id: 1, title: "Photo")
        ]
        let manager = PhotosManager(repository: repository)
        let coordinator = PhotosCoordinator(
            navigationController: UINavigationController())
        viewController = PhotosViewController(
            photosMananger: manager,
            coordinator: coordinator)
        
        // load view
        _ = viewController.view
        
        // tests
        viewController.fetchPhotos()
        XCTAssertTrue(viewController.tableView
            .numberOfRows(inSection: 0) > 0)
        XCTAssertTrue(viewController.tableView
            .visibleCells.count > 0)
    }
}
