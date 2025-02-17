import XCTest
@testable import MVC

final class PhotosRepositoryTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchPhotosSuccess() {
        let repository = MockPhotosRepository()
        repository.data = [
            PhotoEntity(albumId: 1, id: 1, title: "Photo 1")
        ]
        
        repository.getPhotos { result in
            guard let data = result.data else {
                XCTFail("Expected data to be non-nil")
                return
            }
            
            XCTAssertEqual(data.count, 1)
            XCTAssertEqual(data.first?.id ?? 0, 1)
        }
    }
    
    func testFetchPhotosError() {
        let repository = MockPhotosRepository()
        repository.error = APIError.noData
        
        repository.getPhotos { result in
            guard let error = result.error as? APIError else {
                XCTFail("Expected error to be of type APIError")
                return
            }
            
            XCTAssertEqual(error.localizedDescription,
                           APIError.noData.localizedDescription)
        }
    }
}
