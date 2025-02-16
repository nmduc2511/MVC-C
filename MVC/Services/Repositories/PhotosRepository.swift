import Foundation

protocol PhotosRepositoryProtocol {
    func getPhotos(completionHandler handler: @escaping (APIOutput<[PhotoEntity]>) -> Void)
}
