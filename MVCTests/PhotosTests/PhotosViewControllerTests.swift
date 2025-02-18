import XCTest
@testable import MVC

// test_ViewControllerMethod_ExpectedBehavior()

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
    
    func test_Outlet_ShouldSetupUIComponents() {
        // Arrange
        viewController.photosMananger = PhotosManager(
            repository: repository)
        
        // Act
        _ = viewController.view
        
        // Assert
        XCTAssertNotNil(viewController.view)
        XCTAssertNotNil(viewController.tableView)
    }
    
    func test_Dependencies_ShouldSetupDependencies() {
        // Arrange
        viewController.photosMananger = PhotosManager(
            repository: repository)
        viewController.coordinator = coordinator
        
        // Assert
        XCTAssertNotNil(viewController.photosMananger)
        XCTAssertNotNil(viewController.coordinator)
    }
    
    func test_FetchPhotos_ShouldUpdateTableView() {
        // Arrange
        repository.data = [
            PhotoEntity(albumId: 1, id: 1, title: "Photo")
        ]
        
        viewController.photosMananger = PhotosManager(
            repository: repository)
        
        // Act
        _ = viewController.view
        viewController.fetchPhotos()
        
        // Assert
        XCTAssertTrue(viewController.tableView
            .numberOfRows(inSection: 0) > 0)
        XCTAssertTrue(viewController.tableView
            .visibleCells.count > 0)
    }
    
    func test_GoToPhotoDetail_ShoudPushToPhotoViewController() {
        // Arrange
        let photo = PhotoEntity(albumId: 1, id: 1, title: "Photo")
        viewController.coordinator = coordinator
        
        // Act
        viewController.gotoPhotoDetail(photo)
        
        // Assert
        XCTAssertTrue(coordinator.didGotoPhotoDetailCalled)
    }
}
