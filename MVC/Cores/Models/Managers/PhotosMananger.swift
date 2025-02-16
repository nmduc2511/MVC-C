import Foundation

final class PhotosMananger {
    let repository: PhotosRepository
    var photos: [PhotoEntity] = []
    
    init(repository: PhotosRepository) {
        self.repository = repository
    }
    
    var numberOfPhotos: Int {
        return photos.count
    }
    
    func photoAtIndex(_ index: Int) -> PhotoEntity? {
        guard index >= 0 && index < photos.count else {
            return nil
        }
        return photos[index]
    }
    
    func fetchPhotos(success: @escaping () -> Void,
                     failure: @escaping (Error?) -> Void) {
        repository.getPhotos {
            [weak self] (output: APIOutput<[PhotoEntity]>) in
            guard let photos = output.data else {
                DispatchQueue.main.async {
                    failure(output.error)
                }
                return
            }
            
            guard let self = self else { return }
            self.photos = photos
            DispatchQueue.main.async {
                success()
            }
        }
    }
}
