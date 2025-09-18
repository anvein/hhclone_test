import Foundation

enum ApiError: Error {
    case invalidUrl
    case invalidRequest(Error)
    case invalidResponse(Error)

    case requestFailed(Error)
    case serverError(statusCode: Int, data: Data)
}

struct ResponseError: Error {
    let message: String
}
