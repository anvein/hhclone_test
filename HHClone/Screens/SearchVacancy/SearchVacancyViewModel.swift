import Foundation

final class SearchVacancyViewModel: ObservableObject {

    private let vacancyService: VacancyService

    // MARK: - Data

    private var vacanciesModels: [Vacancy] = []
    @Published var vacancies: [VacancyRowViewModel] = []

    let sortTypes: [VacancyListSortType] = VacancyListSortType.allCases
    @Published var selectedSortType: VacancyListSortType = .defaultValue

    @Published var responseSheetViewModel: VacancyResponseViewModel? = nil
    @Published var responseSheetHeight: CGFloat = VacancyResponseSheet.defaultHeight

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

    func showResponseSheet(for vacancyId: UUID) {
        guard let vacancyModel = getVacancyModel(by: vacancyId) else { return }

        responseSheetHeight = VacancyResponseSheet.defaultHeight
        responseSheetViewModel = .init(
            vacancyId: vacancyModel.id,
            title: vacancyModel.title
        )
    }

    @MainActor
    func updateVacancyData(_ vacancy: Vacancy) {
        guard let modelIndex = getVacancyModelIndex(by: vacancy.id),
              let vmIndex = getVacancyViewModelIndex(by: vacancy.id) else { return }

        vacanciesModels[modelIndex] = vacancy
        vacancies[vmIndex].update(from: vacancy)
    }

    // MARK: - Working with data

    private func performLoadVacancies(append: Bool = false) {
        isLoading = true

        Task(priority: .userInitiated) { [weak self] in
            guard let self else { return }

            try? await Task.sleep(nanoseconds: 500_000_000) // TODO: УДАЛИТЬ, КОД ДЛЯ РАЗРАБОТКИ

            do {
                let result = try await self.vacancyService.fetchVacancies(
                    pagination: pagination,
                    sortType: selectedSortType
                )

                await MainActor.run {
                    self.pagination = result.pagination
                    if append {
                        self.vacanciesModels += result.vacancies
                        self.vacancies += result.vacancies.map({ .init(vacancy: $0) })
                    } else {
                        self.vacanciesModels = result.vacancies
                        self.vacancies = result.vacancies.map({ .init(vacancy: $0) })
                    }

                    self.isLoading = false
                }
            } catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    self.isLoading = false

                    // TODO: обработать ошибку - показать
                    print("Failed to fetch vacancies:", error)
                }
            }
        }
    }

    func toggleIsFavourite(with vacancyId: UUID) {
        guard let modelIndex = getVacancyModelIndex(by: vacancyId),
              let vacancyModel = vacanciesModels[safe: modelIndex],
              let vacancyVM = getVacancyViewModel(by: vacancyId),
              !vacancyVM.isUpdating else { return }

        Task { [weak self] in
            guard let self else { return }

            let newValue = !vacancyModel.isFavourite

            do {
                await MainActor.run {
                    vacancyVM.isFavourite = newValue
                    vacancyVM.isUpdating = true
                }

                let updatedVacancyModel = try await self.vacancyService.updateVacancy(
                    isFavorite: newValue,
                    with: vacancyId
                )

                await MainActor.run { [weak self] in
                    guard let self else { return }

                    vacancyVM.isUpdating = false
                    self.vacanciesModels[modelIndex] = updatedVacancyModel
                    self.updateRowViewModel(from: updatedVacancyModel)
                }
            } catch {
                // TODO: обработать и показать ошибку
                await MainActor.run {
                    vacancyVM.isFavourite = !newValue
                }
            }
        }
    }

    // MARK: - Helpers

    private func getVacancyModelIndex(by id: UUID) -> Int? {
        vacanciesModels.firstIndex { $0.id == id }
    }

    private func getVacancyModel(by id: UUID) -> Vacancy? {
        vacanciesModels.first { $0.id == id }
    }

    private func getVacancyViewModelIndex(by id: UUID) -> Int? {
        vacancies.firstIndex { $0.id == id }
    }

    private func getVacancyViewModel(by id: UUID) -> VacancyRowViewModel? {
        guard let index = getVacancyViewModelIndex(by: id),
              let vm = vacancies[safe: index] else { return nil }

        return vm
    }

    @MainActor
    private func updateRowViewModel(from model: Vacancy) {
        guard let vm = getVacancyViewModel(by: model.id)  else { return }
        vm.update(from: model)
    }

    private func resetData() {
        vacanciesModels = []
        vacancies = []
        pagination.reset()
    }

}
