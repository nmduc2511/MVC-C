import XCTest
@testable import MVC

final class PhotosCoordinatorTests: XCTestCase {
    var appCoordinator: AppCoordinator!
    var coordinator: PhotosCoordinator!
    var navigation: UINavigationController!
    
    override func setUp() {
        super.setUp()
        navigation = UINavigationController()
        appCoordinator = AppCoordinator(
            navigationController: navigation)
        coordinator = PhotosCoordinator(
            navigationController: navigation)
    }
    
    override func tearDown() {
        super.tearDown()
        navigation = nil
        appCoordinator = nil
        coordinator = nil
    }
    
    func testPushToPhotoDetail() {
        appCoordinator.start()
        coordinator.gotoPhotoDetail(photo: PhotoEntity())
        
        XCTAssertTrue(navigation.viewControllers.first is PhotosViewController)
        XCTAssertTrue(navigation.viewControllers.last is PhotoViewController)
        XCTAssertTrue(navigation.viewControllers.count == 2)
    }
}
