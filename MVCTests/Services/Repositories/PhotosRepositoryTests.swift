import XCTest
@testable import MVC

final class PhotosRepositoryTests: XCTestCase {
    var repository: PhotosRepositoryProtocol!
    
    override func setUp() {
        super.setUp()
        repository = PhotosRepository()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchPhotosReturnsData() {
        // Given
        let expectation = self.expectation(description: "Fetch Photos")
        
        // When
        repository.getPhotos { (output: APIOutput<[PhotoEntity]>) in
            guard let photos = output.data else {
                let error = output.error ?? APIError.unknownError
                XCTFail("Expected success but got error: \(error)")
                return
            }
            
            XCTAssertNotNil(photos, "Expected non-nil photos array")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}
