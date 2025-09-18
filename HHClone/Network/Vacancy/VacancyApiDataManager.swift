import Foundation

final class VacancyApiDataManager {

    let manager: NetworkManager

    init(manager: NetworkManager) {
        self.manager = manager
    }

    func fetchVacancyList(
        pagination: PaginationRequestDto,
        sortType: VacancyListSortTypeApiDto
    ) async throws -> VacancyListResponseDto {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        return try await manager.request(
            request: .init(
                route: VacancyRoute.getList(searchType: sortType)
            )
            .setPagination(pagination),
            decoder: decoder
        )
    }
    
}
