import XCTest
@testable import MVC

// test_MethodBeingTested_ExpectedOutcome()

final class PhotosManagerTests: XCTestCase {
    var manager: PhotosManager!
    var repository: MockPhotosRepository!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        manager = nil
        repository = nil
    }
    
    func test_FetchPhotos_ShouldReturnPhotoArray() {
        // Arrange
        let photos = [
            PhotoEntity(albumId: 1, id: 1, title: "Photo")]
        repository = MockPhotosRepository()
        repository.data = photos
        
        manager = PhotosManager(repository: repository)
        
        // Act
        manager.fetchPhotos(
            success: {
                // Assert
                XCTAssertTrue(self.manager.numberOfPhotos > 0)
                XCTAssertFalse(self.manager.photos.isEmpty)
            },
            failure: { _ in })
    }
    
    func test_FetchPhotos_ShouldReturnError() {
        // Arrange
        repository = MockPhotosRepository()
        repository.error = APIError.unknownError
        manager = PhotosManager(repository: repository)
        
        // Act
        manager.fetchPhotos(
            success: { },
            failure: { error in
                // Assert
                XCTAssertNotNil(error)
            })
    }
}
