import Foundation

enum VacancyRoute: ApiRoute {
    case getList(searchType: VacancyListSortTypeApiDto)

    var path: [String] {
        switch self {
        case .getList(_):
            ["api", "vacancies"]
        }
    }

    var queryParams: [URLQueryItem] {
        switch self {
        case .getList(let searchType):
            return [
                .init(name: "search", value: searchType.rawValue)
            ]
        }
    }
}
