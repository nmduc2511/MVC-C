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
        let coordinator = PhotoCoordinator(
            navigationController: navigationController
        )
        let controller = PhotoViewController(
            photo: photo,
            coordinator: coordinator
        )
        navigationController.pushViewController(controller, animated: true)
    }
}
