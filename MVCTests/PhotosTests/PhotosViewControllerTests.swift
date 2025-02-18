import XCTest
@testable import MVC

class PhotosViewControllerTests: XCTestCase {
    var repository: MockPhotosRepository!
    var coordinator: MockPhotosCoordinator!
    var viewController: PhotosViewController!
    
    override func setUp() {
        super.setUp()
        viewController = PhotosViewController()
        coordinator = MockPhotosCoordinator()
        repository = MockPhotosRepository()
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
        coordinator = nil
        repository = nil
    }
    
    func testIbOutlet() {
        // Given
        viewController.photosMananger = PhotosManager(
            repository: repository)
        
        // When
        _ = viewController.view
        
        // Then
        XCTAssertNotNil(viewController.view)
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testDependencies() {
        // Given
        viewController.photosMananger = PhotosManager(
            repository: repository)
        viewController.coordinator = coordinator
        
        // Then
        XCTAssertNotNil(viewController.photosMananger)
        XCTAssertNotNil(viewController.coordinator)
    }
    
    func testPhotosDisplaying() {
        // Given
        repository.data = [
            PhotoEntity(albumId: 1, id: 1, title: "Photo")
        ]
        
        viewController.photosMananger = PhotosManager(repository: repository)
        viewController.coordinator = coordinator
        
        // When
        _ = viewController.view
        viewController.gotoPhotoDetail(PhotoEntity())
        
        // Then
        XCTAssertTrue(viewController.tableView
            .numberOfRows(inSection: 0) > 0)
        XCTAssertTrue(viewController.tableView
            .visibleCells.count > 0)
    }
    
    func testGoingToPhotoDetail() {
        // Given
        let photo = PhotoEntity(albumId: 1, id: 1, title: "Photo")
        viewController.coordinator = coordinator
        
        // When
        viewController.gotoPhotoDetail(photo)
        
        // Then
        XCTAssertTrue(coordinator.didGotoPhotoDetailCalled)
    }
}
