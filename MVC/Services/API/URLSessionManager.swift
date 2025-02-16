import Foundation

final class URLSessionManager: APIProtocol {
    private let session: URLSession
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func request<T: Decodable>(input: APIInputProtocol,
                               completion: @escaping (APIOutput<T>) -> Void) {
        guard let url = URL(string: input.url) else {
            completion(APIOutput(data: nil, error: APIError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = input.method
        
        if let parameters = input.parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        print("\n------------REQUEST INPUT")
        print("link: %@", input.url)
        print("body: %@", input.parameters ?? "No Parameter")
        print("------------ END REQUEST INPUT\n")
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(APIOutput(error: APIError.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(APIOutput(error: APIError.invalidResponse(statusCode: -1)))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                break // Continue processing
            case 401:
                completion(APIOutput(error: APIError.unauthorized))
                return
            case 403:
                completion(APIOutput(error: APIError.forbidden))
                return
            case 404:
                completion(APIOutput(error: APIError.notFound))
                return
            case 500...599:
                completion(APIOutput(error: APIError.serverError(statusCode: httpResponse.statusCode)))
                return
            default:
                completion(APIOutput(error: APIError.invalidResponse(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(APIOutput(error: APIError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(APIOutput(data: decodedData))
            } catch {
                completion(APIOutput(error: APIError.decodingError(error)))
            }
        }
        task.resume()
    }
}
