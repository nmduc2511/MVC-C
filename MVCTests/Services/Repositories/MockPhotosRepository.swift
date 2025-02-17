import Foundation
@testable import MVC

final class MockPhotosRepository: PhotosRepositoryProtocol {
    var data: [PhotoEntity]?
    var error: APIError?
    
    func getPhotos(completionHandler handler: @escaping (MVC.APIOutput<[MVC.PhotoEntity]>) -> Void) {
        let output = MVC.APIOutput(data: data, error: error)
        handler(output)
    }
}
