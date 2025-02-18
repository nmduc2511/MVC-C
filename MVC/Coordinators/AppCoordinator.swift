import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let manager = PhotosManager(
            repository: PhotosRepository()
        )
        let coordinator = PhotosCoordinator(
            navigationController: navigationController
        )
        let controller = PhotosViewController()
        controller.photosMananger = manager
        controller.coordinator = coordinator
        navigationController.viewControllers = [controller]
    }
}
