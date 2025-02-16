protocol APIInputProtocol {
    var url: String { get }
    var method: String { get }
    var parameters: [String: Any]? { get }
}
