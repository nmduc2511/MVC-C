import XCTest
@testable import MVC

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
    
    func testPushToPhotoDetail() {
        // Given
        photosCoordinator.gotoPhotoDetail(photo: PhotoEntity())
        
        // Then
        XCTAssertTrue(photosCoordinator.didGotoPhotoDetailCalled)
    }
}
