import Foundation

final class VacancyService {
    private let apiDataManager: VacancyApiDataManager
    private let mapper: VacancyMapper

    init(apiDataManager: VacancyApiDataManager, mapper: VacancyMapper) {
        self.apiDataManager = apiDataManager
        self.mapper = mapper
    }

    func fetchVacancies(pagination: Pagination, sortType: VacancyListSortType) async -> [Vacancy] {
        do {
            let apiResult: VacancyListResponseDto = try await apiDataManager.fetchVacancyList(
                pagination: pagination.toApiDto(),
                sortType: sortType.toApiDto()
            )

            return mapper.map(from: apiResult.items)
        } catch let error {
            print(error) // логировать
            return []
        }
    }
}
