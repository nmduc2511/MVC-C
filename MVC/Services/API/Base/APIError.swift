import Foundation

// MARK: - API Error Enum
enum APIError: Error {
    case invalidURL
    case invalidResponse(statusCode: Int)
    case noData
    case decodingError(Error)
    case networkError(Error)
    case timeout
    case unauthorized
    case forbidden
    case notFound
    case serverError(statusCode: Int)
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL provided."
        case .invalidResponse(let statusCode):
            return "Invalid response from server with status code: \(statusCode)."
        case .noData:
            return "No data received from the server."
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error occurred: \(error.localizedDescription)"
        case .timeout:
            return "The request timed out. Please try again."
        case .unauthorized:
            return "Unauthorized access. Please check your credentials."
        case .forbidden:
            return "Access forbidden. You do not have permission to perform this action."
        case .notFound:
            return "The requested resource was not found."
        case .serverError(let statusCode):
            return "Server error occurred with status code: \(statusCode)."
        case .unknownError:
            return "An unknown error occurred. Please try again later."
        }
    }
}
