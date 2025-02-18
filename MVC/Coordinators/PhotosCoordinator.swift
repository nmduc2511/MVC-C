import UIKit

protocol PhotosCoordinatorProtocol: Coordinator {
    func gotoPhotoDetail(photo: PhotoEntity)
}

final class PhotosCoordinator: PhotosCoordinatorProtocol {
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func gotoPhotoDetail(photo: PhotoEntity) {
        let controller = PhotoViewController()
        controller.photo = photo
        controller.coordinator = PhotoCoordinator(
            navigationController: navigationController
        )
        navigationController.pushViewController(controller, animated: true)
    }
}
