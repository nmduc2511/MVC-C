import XCTest
@testable import MVC

// test_NavigationMethod_ShouldNavigateToExpectedScreen()

final class PhotosCoordinatorTests: XCTestCase {
    var photosCoordinator: MockPhotosCoordinator!
    
    override func setUp() {
        super.setUp()
        photosCoordinator = MockPhotosCoordinator()
    }
    
    override func tearDown() {
        super.tearDown()
        photosCoordinator = nil
    }
    
    func test_GotoPhotoDetail_PushViewControllerSuccess() {
        // Arrange
        photosCoordinator.gotoPhotoDetail(photo: PhotoEntity())
        
        // Assert
        XCTAssertTrue(photosCoordinator.didGotoPhotoDetailCalled)
    }
}
