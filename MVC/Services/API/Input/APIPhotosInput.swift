struct APIPhotosInput: APIInputProtocol {
    var url: String {
        return "https://jsonplaceholder.typicode.com/photos"
    }
    
    var method: String {
        return HTTPMethod.GET.rawValue
    }
    
    var parameters: [String : Any]? {
        return nil
    }
}
