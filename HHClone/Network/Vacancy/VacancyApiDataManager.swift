import Foundation

final class VacancyApiDataManager {

    private let manager: NetworkManager
    private let dateFormatter: DateFormatter
    private let decoder: JSONDecoder

    init(manager: NetworkManager) {
        self.manager = manager

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        self.dateFormatter = dateFormatter

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        self.decoder = decoder
    }

    func getVacancy(with id: UUID) async throws -> VacancyItemResponseDto {
        return try await manager.request(
            request: .init(
                route: VacancyRoute.getVacancy(id: id)
            ),
            decoder: decoder
        )
    }

    func getVacancyList(
        pagination: PaginationRequestDto,
        sortType: VacancyListSortTypeApiDto
    ) async throws -> VacancyListResponseDto {
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

    func patchVacancyIsFavorite(
        _ isFavorite: Bool,
        id: UUID
    ) async throws -> VacancyItemResponseDto {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        return try await manager.request(
            request: .init(
                route: VacancyRoute.patchIsFavorite(id: id),
                body: VacancyPatchIsFavoriteRequestDto(isFavorite: isFavorite)
            ),
            decoder: decoder
        )
    }

}
