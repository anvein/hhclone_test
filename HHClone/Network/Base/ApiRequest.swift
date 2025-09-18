import Foundation

class ApiRequest {
    let route: ApiRoute
    let body: ApiRequestBodyDto?
    var pagination: PaginationRequestDto?

    init(route: ApiRoute, body: ApiRequestBodyDto? = nil) {
        self.route = route
        self.body = body
    }

    func setPagination(_ pagination: PaginationRequestDto) -> Self {
        self.pagination = pagination
        return self
    }

    // TODO: сделать поддержку мидлвэров
    // TODO: сделат возможность указывать авторизацию
    // throws: ApiError
    func buildUrlRequest(baseUrl: URL) throws -> URLRequest {
        guard var url = URL(string: baseUrl.baseUrlString + "/" + route.pathString) else {
            throw ApiError.invalidUrl
        }

        var paginationQueryParams: [URLQueryItem] = []
        if let pagination {
            paginationQueryParams = [
                .init(name: "page", value: String(pagination.page))
            ]
        }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = route.queryParams + paginationQueryParams

        url = urlComponents?.url ?? url

        var request = URLRequest(url: url)
        request.httpMethod = route.method.rawValue
        request.allHTTPHeaderFields = route.headers

        if let body = body, route.method != .get {
            do {
                request.httpBody = try JSONEncoder().encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch let error {
                throw ApiError.invalidRequest(error)
            }
        }

        return request
    }
}
