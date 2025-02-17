import XCTest
@testable import MVC

final class PhotoViewControllerTests: XCTestCase {
    var coordinator: PhotoCoordinator!
    var viewController: PhotoViewController!
    var photo: PhotoEntity!
    
    override func setUp() {
        super.setUp()
        photo = PhotoEntity(
            albumId: 0, id: 1, title: "Photo Title",
            url: "https://via.placeholder.com/600/92c952",
            thumbnailUrl: "https://via.placeholder.com/150/92c952")
        coordinator = PhotoCoordinator(
            navigationController: UINavigationController())
        viewController = PhotoViewController(
            photo: photo,
            coordinator: coordinator)
    }
    
    override func tearDown() {
        super.tearDown()
        coordinator = nil
        viewController = nil
    }
    
    func testIBOutlets() {
        _ = viewController.view
        XCTAssertNotNil(viewController.titleLabel)
        XCTAssertNotNil(viewController.photoImageView)
    }
    
    func testTheAccuracyOfData() {
        XCTAssertEqual(viewController.photo, photo)
    }
    
    func testTheAccuracyOfUI() {
        _ = viewController.view
        XCTAssertEqual(viewController.titleLabel?.text, photo.title)
        let expectation = self.expectation(description: "Image loads")
        viewController
            .photoImageView
            .sd_setImage(with: URL(string: photo.newUrl)) { image,_,_,_ in
                XCTAssertNotNil(image, "Image should be loaded successfully")
                expectation.fulfill()
            }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
}
