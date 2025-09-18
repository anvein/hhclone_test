import Foundation

final class SearchVacancyViewModel: ObservableObject {

    let vacancyService: VacancyService

    @Published var vacancies: [VacancyRowViewModel] = []
    private var vacanciesModels: [Vacancy] = []

    let sortTypes: [VacancyListSortType] = VacancyListSortType.allCases
    @Published var selectedSortType: VacancyListSortType = .defaultValue

    @Published var isLoading: Bool = false
    var pagination: Pagination = .init()

    // MARK: - Init

    init(vacancyService: VacancyService) {
        self.vacancyService = vacancyService
    }

    // MARK: - API for UI

    func reloadVacancies() {
        guard !isLoading else { return }

        resetData()
        performLoadVacancies()
    }

    func loadNextPageVacanciesIfNeeded() {
        guard !isLoading, pagination.hasNextPage else { return }

        pagination.nextPage()
        performLoadVacancies(append: true)
    }

    // MARK: - Working with data

    private func performLoadVacancies(append: Bool = false) {
        isLoading = true

        Task.detached(priority: .userInitiated) { [weak self] in
            guard let self else { return }

            try? await Task.sleep(nanoseconds: 2_000_000_000)
            let models = await self.vacancyService.fetchVacancies(
                pagination: pagination,
                sortType: selectedSortType
            )

            await MainActor.run {
                defer { self.isLoading = false }

                if append {
                    self.vacanciesModels += models
                    self.vacancies += models.map({ .init(vacancy: $0) })
                } else {
                    self.vacanciesModels = models
                    self.vacancies = models.map({ .init(vacancy: $0) })
                }

                // TODO: сделать чтобы эти данные брались из API
                if models.isEmpty {
                    self.pagination.fillTotalPagesFromPage()
                }
            }
        }
    }

    func toggleIsFavourite(of vacancy: VacancyRowViewModel) {
        guard let index = getVacancyModelIndex(by: vacancy.id) else {
            return
        }

        // TODO: переделать на работу с API
        // обновление модели в data manager
        let indexMock = Vacancy.mockList.firstIndex { $0.id == vacancy.id }
        if let indexMock {
            Vacancy.mockList[indexMock].isFavourite.toggle()
        }

        vacanciesModels[index].isFavourite.toggle()

        Task { @MainActor in
            vacancies[index].isFavourite.toggle()
        }
    }

    // MARK: - Helpers

    private func getVacancyModelIndex(by id: UUID) -> Int? {
        vacanciesModels.firstIndex { $0.id == id }
    }

    private func resetData() {
        vacanciesModels = []
        vacancies = []
        pagination.reset()
    }

}
