import UIKit
@testable import MVC

final class MockAppCoordinator: Coordinator {
    var navigationController: UINavigationController!
    var didStartPhotosCoordinator = false
    
    func start() {
        didStartPhotosCoordinator = true
    }
}
