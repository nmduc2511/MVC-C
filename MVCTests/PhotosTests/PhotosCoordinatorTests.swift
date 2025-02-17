import XCTest
@testable import MVC

final class PhotosCoordinatorTests: XCTestCase {
    var appCoordinator: MockAppCoordinator!
    var photosCoordinator: MockPhotosCoordinator!
    
    override func setUp() {
        super.setUp()
        appCoordinator = MockAppCoordinator()
        photosCoordinator = MockPhotosCoordinator()
    }
    
    override func tearDown() {
        super.tearDown()
        appCoordinator = nil
        photosCoordinator = nil
    }
    
    func testPushToPhotoDetail() {
        // Given
        appCoordinator.start()
        photosCoordinator.gotoPhotoDetail(photo: PhotoEntity())
        
        // Then
        XCTAssertTrue(appCoordinator.didStartPhotosCoordinator)
        XCTAssertTrue(photosCoordinator.didGotoPhotoDetailCalled)
    }
}
