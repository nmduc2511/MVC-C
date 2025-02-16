import Foundation

struct PhotoEntity: Codable, Equatable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
    var newThumbnailUrl: String {
        return thumbnailUrl
            .replacingOccurrences(of: "via.placeholder.com",
                                  with: "dummyimage.com")
    }
    
    var newUrl: String {
        return url
            .replacingOccurrences(of: "via.placeholder.com",
                                  with: "dummyimage.com")
    }
    
    init(albumId: Int = 0,
         id: Int = 0,
         title: String = "",
         url: String = "",
         thumbnailUrl: String = "") {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
    
    static func == (lhs: PhotoEntity, rhs: PhotoEntity) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.albumId == rhs.albumId &&
        lhs.url == rhs.url &&
        lhs.thumbnailUrl == rhs.thumbnailUrl &&
        lhs.newUrl == rhs.newUrl &&
        lhs.newThumbnailUrl == rhs.newThumbnailUrl

    }
}
