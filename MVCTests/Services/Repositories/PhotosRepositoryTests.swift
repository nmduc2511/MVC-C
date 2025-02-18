import XCTest
@testable import MVC

// test_MethodBeingTested_ExpectedRepositoryResult()

final class PhotosRepositoryTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_FetchPhotos_ShouldReturnPhotoArray() {
        // Arrange
        let repository = MockPhotosRepository()
        repository.data = [
            PhotoEntity(albumId: 1, id: 1, title: "Photo 1")
        ]
        
        // Act
        repository.getPhotos { result in
            guard let data = result.data else {
                XCTFail("Expected data to be non-nil")
                return
            }
            
            // Arrange
            XCTAssertEqual(data.count, 1)
            XCTAssertEqual(data.first?.id ?? 0, 1)
        }
    }
    
    func test_FetchPhotos_ShouldReturnError() {
        // Arrange
        let repository = MockPhotosRepository()
        repository.error = APIError.noData
        
        // Act
        repository.getPhotos { result in
            guard let error = result.error as? APIError else {
                XCTFail("Expected error to be of type APIError")
                return
            }
            
            // Arrange
            XCTAssertEqual(error.localizedDescription,
                           APIError.noData.localizedDescription)
        }
    }
}
