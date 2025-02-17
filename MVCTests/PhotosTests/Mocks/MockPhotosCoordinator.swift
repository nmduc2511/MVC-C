import UIKit
@testable import MVC

final class MockPhotosCoordinator: PhotosCoordinatorProtocol {
    var navigationController: UINavigationController!
    var didGotoPhotoDetailCalled = false
    
    func gotoPhotoDetail(photo: MVC.PhotoEntity) {
        didGotoPhotoDetailCalled = true
    }
}
