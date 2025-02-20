# iOS MVC-Coordinator

This project demonstrates how to implement a repository list in Swift using MVC, SOLID principles, and Dependency Injection, ensuring a well-structured, testable, and scalable codebase.

## Table of Contents

- [Model View Controller](#ios-mvc-coordinator)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Architecture](#architecture)
    - [Models](#models)
    - [Views](#views)
    - [Controllers](#controllers)
  - [Dependency Injection](#dependency-injection)
  - [Unit Tests](#unit-tests)
  - [Project Folder and File Structure](#project-folder-and-file-structure)
  - [Conclusion](#conclusion)
  - [Related](#related)

## Introduction
The MVC-Coordinator project demonstrates how to implement the Model-View-Controller (MVC) pattern effectively. It fetches and displays a list of photos from a remote URL, illustrating how MVC helps structure code in a clean and maintainable way.
This project also follows SOLID principles to improve maintainability and scalability, ensuring that the codebase remains flexible and easy to extend.
## Architecture

<img width="600" alt="High Level Overview" src="images/model_view_controller.png">

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
}
```
## Dependency Injection
Dependency Injection (DI) is a technique that provides objects with the things they need instead of creating them directly. This makes testing easier and keeps different parts of the app loosely connected.
Repositories and Coordinators can be injected into a ViewController or Manager via property injection or initializer. Here is how the dependency injection is set up.
### Coordinators
Protocols should define the necessary variables and functions, making the code easier to decouple, maintain, and test
```swift
import UIKit

protocol Coordinator { }

protocol PhotosCoordinatorProtocol: Coordinator {
    func gotoPhotoDetail(photo: PhotoEntity)
}

final class PhotosCoordinator: PhotosCoordinatorProtocol {
    func gotoPhotoDetail(photo: PhotoEntity) { }
}
```
Mock Test with Coordinator

```swift
@testable import MVC

final class MockPhotosCoordinator: PhotosCoordinatorProtocol {
    var didGotoPhotoDetailCalled = false
    
    func gotoPhotoDetail(photo: MVC.PhotoEntity) {
        didGotoPhotoDetailCalled = true
    }
}
```

### Repositories
Protocols should define the necessary variables and functions, making the code easier to decouple, maintain, and test

```swift
protocol PhotosRepositoryProtocol {
    func getPhotos(completionHandler handler: @escaping (APIOutput<[PhotoEntity]>) -> Void)
}

final class PhotosRepository: PhotosRepositoryProtocol {
    .../
    func getPhotos(completionHandler handler: @escaping (APIOutput<[PhotoEntity]>) -> Void) {
        let input = APIPhotosInput()
        api.request(input: input, completion: handler)
    }
}
```

Mock Test with Coordinator
```swift
@testable import MVC

final class MockPhotosRepository: PhotosRepositoryProtocol {
    var data: [PhotoEntity]?
    var error: APIError?
    
    func getPhotos(completionHandler handler: @escaping (MVC.APIOutput<[MVC.PhotoEntity]>) -> Void) {
        let output = MVC.APIOutput(data: data, error: error)
        handler(output)
    }
}
```

### How do you inject dependencies using contructor or property ?
```swift
func start() {
    let manager = PhotosManager(
        repository: PhotosRepository() // contructor inject
    )
    let coordinator = PhotosCoordinator(
        navigationController: navigationController // contructor inject
    )
    let controller = PhotosViewController()
    controller.photosMananger = manager // property inject 
    controller.coordinator = coordinator // property inject
    navigationController.viewControllers = [controller]
}
```

## Unit Tests

### What to test?
Unit tests are crucial for verifying the functionality and reliability of your application. In this architecture, we can test Models, Coordinators, ViewControllers and Repositories (if they contain business logic).
#### Model Tests
```swift
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

    .../
}
```
#### Coordinator Tests
```swift
import XCTest
@testable import MVC

final class AppCoordinatorTests: XCTestCase {
    var coordinator: MockAppCoordinator!
    
    override func setUp() { }
    
    override func tearDown() { }
    
    func test_Start_ShouldInitializeRootViewController() {
        // Act
        coordinator.start()
        
        // Assert
        XCTAssertTrue(coordinator.didStartPhotosCoordinator)
    }

    .../
}
```
#### Repository Tests
```swift
import XCTest
@testable import MVC

final class PhotosRepositoryTests: XCTestCase {
    override func setUp() { }
    
    override func tearDown() { }
    
    func test_FetchPhotos_ShouldReturnPhotoArray() {
        // Arrange
        let repository = MockPhotosRepository()
        repository.data = [
            PhotoEntity(albumId: 1, id: 1, title: "Photo 1")
        ]
        
        // Act
        repository.getPhotos { result in
            guard let data = result.data else {
                XCTFail("Expected data to be non-nil")
                return
            }
            
            // Arrange
            XCTAssertEqual(data.count, 1)
            XCTAssertEqual(data.first?.id ?? 0, 1)
        }
    }

    .../
}
```
#### ViewControllers
```swift
import XCTest
@testable import MVC

class PhotosViewControllerTests: XCTestCase {
    var repository: MockPhotosRepository!
    var coordinator: MockPhotosCoordinator!
    var viewController: PhotosViewController!
    
    override func setUp() {
        super.setUp()
        viewController = PhotosViewController()
        coordinator = MockPhotosCoordinator()
        repository = MockPhotosRepository()
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
        coordinator = nil
        repository = nil
    }
    
    func test_Outlet_ShouldSetupUIComponents() {
        // Arrange
        viewController.photosMananger = PhotosManager(
            repository: repository)
        
        // Act
        _ = viewController.view
        
        // Assert
        XCTAssertNotNil(viewController.view)
        XCTAssertNotNil(viewController.tableView)
    }

    .../
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
## Conclusion
This project demonstrates how to use the MVC (Model-View-Controller) pattern in a Swift app by separating the code into clear parts, making it easier to manage, test, and expand. It follows **SOLID principles** to ensure clean, maintainable code and uses **Dependency Injection** to improve flexibility and testability. Following MVC helps build strong apps that can be easily updated and improved. 

Feel free to explore the code, adapt it to your needs, and share any feedback or contributions!

## Related
* [SOLID](https://www.amazon.com/Clean-Architecture-Craftsmans-Software-Structure/dp/0134494164)
* [Dependency Injection](https://toidicodedao.com/2015/11/03/dependency-injection-va-inversion-of-control-phan-1-dinh-nghia/)
* [Model-View-Controller (MVC)](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html)
