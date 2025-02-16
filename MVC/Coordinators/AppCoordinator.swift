import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let manager = PhotosMananger(
            repository: PhotosRepository()
        )
        let coordinator = PhotosCoordinator(
            navigationController: navigationController
        )
        let controller = PhotosViewController(
            photosMananger: manager,
            coordinator: coordinator
        )
        navigationController.viewControllers = [controller]
    }
}
