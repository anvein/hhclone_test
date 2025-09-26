import Foundation

enum VacancyRoute: ApiRoute {
    case getVacancy(id: UUID)
    case getList(searchType: VacancyListSortTypeApiDto)
    case patchIsFavorite(id: UUID)

    var method: ApiHttpMethod {
        switch self {
        case .patchIsFavorite(_): .patch
        default: .get
        }
    }

    var path: [String] {
        let basePathItems = ["api", "vacancies"]

        switch self {
        case .getVacancy(let id):
            return basePathItems + [id.uuidString.lowercased()]
        case .getList(_):
            return basePathItems
        case .patchIsFavorite(let id):
            return basePathItems + [id.uuidString.lowercased(), "favorite"]
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
