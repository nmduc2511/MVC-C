import XCTest
@testable import MVC

final class PhotoTests: XCTestCase {
    
    func testPhotoEntity_DefaultInitialization() {
        // Arrange
        let photo = PhotoEntity()
        
        // Assert
        XCTAssertEqual(photo.albumId, 0)
        XCTAssertEqual(photo.id, 0)
        XCTAssertEqual(photo.title, "")
        XCTAssertEqual(photo.url, "")
        XCTAssertEqual(photo.thumbnailUrl, "")
    }
    
    func testPhotoEntity_CustomInitialization() {
        // Arrange
        let photo = PhotoEntity(albumId: 1, id: 101, title: "Test Photo",
                                url: "https://via.placeholder.com/150",
                                thumbnailUrl: "https://via.placeholder.com/50")

        // Assert
        XCTAssertEqual(photo.albumId, 1)
        XCTAssertEqual(photo.id, 101)
        XCTAssertEqual(photo.title, "Test Photo")
        XCTAssertEqual(photo.url, "https://via.placeholder.com/150")
        XCTAssertEqual(photo.thumbnailUrl, "https://via.placeholder.com/50")
    }

    func testPhotoEntity_NewUrlAndThumbnailUrl() {
        // Arrange
        let photo = PhotoEntity(url: "https://via.placeholder.com/150",
                                thumbnailUrl: "https://via.placeholder.com/50")

        // Assert
        XCTAssertEqual(photo.newUrl, "https://dummyimage.com/150")
        XCTAssertEqual(photo.newThumbnailUrl, "https://dummyimage.com/50")
    }
    
    func testPhotoEntity_Equality() {
        // Arrange
        let photo1 = PhotoEntity(albumId: 1, id: 101, title: "Same",
                                 url: "https://via.placeholder.com/150",
                                 thumbnailUrl: "https://via.placeholder.com/50")
        let photo2 = PhotoEntity(albumId: 1, id: 101, title: "Same",
                                 url: "https://via.placeholder.com/150",
                                 thumbnailUrl: "https://via.placeholder.com/50")

        // Assert
        XCTAssertEqual(photo1, photo2)
    }
    
    func testPhotoEntity_Inequality() {
        // Arrange
        let photo1 = PhotoEntity(id: 1, title: "Photo A")
        let photo2 = PhotoEntity(id: 2, title: "Photo B") // Different ID and Title

        // Assert
        XCTAssertNotEqual(photo1, photo2)
    }
}
