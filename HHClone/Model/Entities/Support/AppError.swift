import Foundation

enum AppError: Error, LocalizedError {
    case networkError
    case serverError(statusCode: Int)
    case decodingError
    case custom(message: String)

    var errorDescription: String? {
        switch self {
        case .networkError: return "Проблемы с сетью."
        case .serverError(let code): return "Сервер вернул ошибку \(code)."
        case .decodingError: return "Ошибка обработки данных."
        case .custom(let message): return message
        }
    }
}
