import Foundation

final class PhotosRepository: PhotosRepositoryProtocol {
    let api: APIProtocol
    
    init() {
        self.api = URLSessionManager()
    }
    
    func getPhotos(completionHandler handler: @escaping (APIOutput<[PhotoEntity]>) -> Void) {
        let input = APIPhotosInput()
        api.request(input: input, completion: handler)
    }
}
