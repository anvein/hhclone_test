import Foundation

final class VacancyService {
    private let apiDataManager: VacancyApiDataManager
    private let mapper: VacancyMapper

    init(apiDataManager: VacancyApiDataManager, mapper: VacancyMapper) {
        self.apiDataManager = apiDataManager
        self.mapper = mapper
    }

    func fetchVacancy(with id: UUID) async throws -> Vacancy {
        do {
            let apiResult = try await apiDataManager.getVacancy(with: id)

            return mapper.map(from: apiResult)
        } catch let error {
            print(error)  // TODO: логировать
            throw AppError.custom(message: error.localizedDescription)
        }
    }

    func fetchVacancies(
        pagination: Pagination,
        sortType: VacancyListSortType
    ) async throws -> VacancyList {
        do {
            let apiResult = try await apiDataManager.getVacancyList(
                pagination: pagination.toApiDto(),
                sortType: sortType.toApiDto()
            )

            return mapper.map(from: apiResult)
        } catch let error {
            print(error)  // TODO: логировать
            throw AppError.custom(message: error.localizedDescription)
        }
    }

    func updateVacancy(isFavorite: Bool, with id: UUID) async throws -> Vacancy {
        do {
            let apiResult: VacancyItemResponseDto = try await apiDataManager.patchVacancyIsFavorite(
                isFavorite,
                id: id
            )

            return mapper.map(from: apiResult)
        } catch let error {
            print(error)  // TODO: логировать
            throw AppError.custom(message: error.localizedDescription)
        }
    }
}
