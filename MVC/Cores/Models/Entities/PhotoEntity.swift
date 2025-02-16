import Foundation

struct PhotoEntity: Codable {
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
}
