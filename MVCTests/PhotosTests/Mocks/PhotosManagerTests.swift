import XCTest
@testable import MVC

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
    
    func testFetchPhotosSuccess() {
        let photos = [
            PhotoEntity(albumId: 1, id: 1, title: "Photo")]
        repository = MockPhotosRepository()
        repository.data = photos
        
        manager = PhotosManager(repository: repository)
        manager.fetchPhotos(
            success: {
                XCTAssertTrue(self.manager.numberOfPhotos > 0)
                XCTAssertNotNil(self.manager.photoAtIndex(0))
            },
            failure: { error in
                XCTAssertNil(error)
            })
    }
    
    func testFetchPhotosError() {
        repository = MockPhotosRepository()
        repository.error = APIError.unknownError
        
        manager = PhotosManager(repository: repository)
        manager.fetchPhotos(
            success: { [weak self] in
                guard let self = self else { return }
                XCTAssertTrue(self.manager.numberOfPhotos == 0)
                XCTAssertNotNil(self.manager.photoAtIndex(0))
            },
            failure: { error in
                XCTAssertNotNil(error)
            })
    }
}
