import Foundation

struct APIOutput<T: Decodable> {
    var data: T?
    var error: (any Error)?
}
