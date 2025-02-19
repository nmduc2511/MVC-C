# iOS MVC-Coordinator
## Introduction
The MVC-Coordinator project demonstrates how to implement the Model-View-Controller (MVC) pattern effectively. It fetches and displays a list of photos from a remote URL, illustrating how MVC helps structure code in a clean and maintainable way.
This project also follows SOLID principles to improve maintainability and scalability, ensuring that the codebase remains flexible and easy to extend.
## Architecture
The architecture is structured into three main layers:
1. **Models**: Handles data and business logic.
2. **Views**: Manages what the user sees and interacts with.
3. **Controllers**: Acts as a bridge between Models and Views.
### Models
Models store and process data (e.g., entities, managers). They don't interact directly with the UI, but notify the controller of data changes, which then updates the view.
#### Entities
An entity can be an object with methods, or it can be a set of data structures and functions. It doesn’t matter so long as the entities can be used by many different applications. — Clean Architecture: A Craftsman’s Guide to Software Structure and Design (Robert C. Martin)
```swift
struct PhotoEntity: Codable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
```
#### Managers
A manager object holds data and provides functions to work with that data, following good software design principles (SOLID).  It uses a clearly defined interface (a "protocol"), which makes it easy to swap out different data sources or use mock data for testing.
```swift
final class PhotosManager {
    let repository: PhotosRepositoryProtocol
    var photos: [PhotoEntity] = []
}
```
### Views
Views display information (text, images, buttons) and respond to user actions, but contain no logic beyond that. They interact with models indirectly through controllers.
### Controllers
Controllers are the middlemen between the user interface (views) and the data (models). They handle communication between them, ensuring the views reflect changes in the data and vice-versa.  Controllers also take care of some setup and organization within the application.
```swift
final class PhotosViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var photosMananger: PhotosManager!
    var coordinator: PhotosCoordinatorProtocol!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Others
    private func setupView() { }
    
    func gotoPhotoDetail(_ photo: PhotoEntity) { }
}
```
## Dependency Injection
Dependency Injection (DI) is a technique that provides objects with the things they need instead of creating them directly. This makes testing easier and keeps different parts of the app loosely connected.
Repositories and Coordinators can be injected into a ViewController or Manager via property injection or initializer. Here is how the dependency injection is set up.
```swift
func start() {
    let manager = PhotosManager(
        repository: PhotosRepository() // initial inject
    )
    let coordinator = PhotosCoordinator(
        navigationController: navigationController // initial inject
    )
    let controller = PhotosViewController()
    controller.photosMananger = manager // property inject 
    controller.coordinator = coordinator // property inject
    navigationController.viewControllers = [controller]
}
```
## Project Folder and File Structure
```
- /CleanArchitecture
    - /MVC
        - /Application
        - /Coordinators
        - /Cores
            - /Models
            - /Views & Controllers
        - /Resources
        - /Services
            - /API
            - /Databases
            - /Repositories
        - /Untilities
            - /Extensions
            - /Constants
    - /MVCTests
          - /Coordinators
              - /Mocks
              - ...Tests
          - /Models
              - /Mocks
          - /Photo
              - /Mocks
          - /Photos
              - /Mocks
          - /Services
              - /Mocks
```

