import Foundation

final class NetworkManager {

    var baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        baseURL: URL,
        sessionConfiguration: URLSessionConfiguration = .default,
        decoder: JSONDecoder
    ) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: sessionConfiguration)
        self.decoder = decoder
    }

    // throws: ApiError
    func request<R: ApiResponseDto>(
        request: ApiRequest,
        decoder: JSONDecoder? = nil
    ) async throws -> R {
        // TODO: мб сделать механизм чтобы baseUrl был не в NetworkManager, а в ApiRequest?
        let urlRequest = try request.buildUrlRequest(baseUrl: baseURL)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError.invalidResponse(
                    ResponseError(message: "Response is not HTTPURLResponse")
                )
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                throw ApiError.serverError(statusCode: httpResponse.statusCode, data: data)
            }

            do {
                let useDecoder = decoder ?? self.decoder
                let decoded = try useDecoder.decode(R.self, from: data)

                return decoded
            } catch let error {
                throw ApiError.invalidResponse(error)
            }

        } catch let error {
            throw ApiError.requestFailed(error)
        }
    }

}
