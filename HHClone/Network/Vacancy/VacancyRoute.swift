import Foundation

enum VacancyRoute: ApiRoute {
    case getList(searchType: VacancyListSortTypeApiDto)
    case patchIsFavorite(id: UUID)

    var method: ApiHttpMethod {
        switch self {
        case .patchIsFavorite(_): .patch
        default: .get
        }
    }

    var path: [String] {
        switch self {
        case .getList(_):
            ["api", "vacancies"]
        case .patchIsFavorite(let id):
            ["api", "vacancies", id.uuidString.lowercased(), "favorite"]
        }
    }

    var queryParams: [URLQueryItem] {
        switch self {
        case .getList(let searchType):
            return [
                .init(name: "search", value: searchType.rawValue)
            ]
        default:
            return []
        }
    }
}
