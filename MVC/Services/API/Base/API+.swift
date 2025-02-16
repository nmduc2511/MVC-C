import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol APIProtocol {
    func request<T: Decodable>(input: APIInputProtocol,
                               completion: @escaping (APIOutput<T>) -> Void)
}
