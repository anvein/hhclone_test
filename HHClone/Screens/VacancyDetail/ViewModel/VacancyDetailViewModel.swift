import SwiftUI
import Foundation

final class VacancyDetailViewModel: ObservableObject {

    private var vacancyService: VacancyService

    // MARK: - Data

    private(set) var vacancyId: UUID
    private var vacancyModel: Vacancy?

    @Published private(set) var viewData: VacancyDetailViewData?

    @Published var responseSheetHeight: CGFloat = VacancyResponseSheet.defaultHeight
    @Published var responseSheetViewModel: VacancyResponseViewModel? = nil

    @Published var isLoading: Bool = false

    // MARK: - Init

    init(vacancyService: VacancyService, vacancyId: UUID) {
        print("VacancyDetailViewModel INIT")
        self.vacancyService = vacancyService
        self.vacancyId = vacancyId
    }

    // MARK: -

    @MainActor
    func loadVacancy() {
        guard !isLoading else { return }
        isLoading = true

        Task { [weak self] in
            guard let self else { return }

            var result: Vacancy? = nil
            do {
                result = try await Task.detached(priority: .background) {
                    // TODO: УДАЛИТЬ, КОД ДЛЯ РАЗРАБОТКИ
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    return try await self.vacancyService.fetchVacancy(with: self.vacancyId)
                }.value
            } catch {
                // TODO: обработать ошибку - показать
                print("Failed to fetch vacancies:", error)
            }


            if let result {
                self.vacancyModel = result
                self.viewData = self.makeViewData(from: result)
            }

            self.isLoading = false
        }
    }

    func fetchVacancy(by vacancyId: UUID) async -> Vacancy? {
        return Vacancy.mockList.first { vacancy in
            vacancy.id == vacancyId
        }
    }

    func showResponseSheet(coverLetterText: String? = nil) {
        guard let vacancyModel else { return }

        responseSheetHeight = VacancyResponseSheet.defaultHeight
        responseSheetViewModel = .init(
            vacancyId: vacancyModel.id,
            title: vacancyModel.title,
            coverLetterText: coverLetterText
        )
    }

    // MARK: -

    private func makeViewData(from vacancy: Vacancy) -> VacancyDetailViewData {
        .init(
            id: vacancy.id,
            isFavourite: vacancy.isFavourite,
            title: vacancy.title,
            descriptionMarkdownContent: vacancy.descriptionMarkdownContent,
            address: formatAddress(vacancy.address),
            locationPoint: .init(latitude: 0, longitude: 0),
            employerTitle: vacancy.employerTitle,
            isEmployerVerify: vacancy.isEmployerVerify,
            experience: vacancy.experience?.text,
            publishedAt: ""/*vacancy.publishedAt*/,
            salary: formatSalaryRange(vacancy.salary),
            attributes: formatAttributes(vacancy),
            responsesCount: vacancy.statistic.responses,
            visitorsNow:  vacancy.statistic.visitorsNow
        )
    }

    // MARK: - Data Format

    private func formatAddress(_ address: Address) -> String {
        // TODO: вынести в форматтер
        "\(address.city), ул. \(address.street), \(address.number)"
    }

    private func formatSalaryRange(_ salary: SalaryRange?) -> String? {
        let from = salary?.from
        let to = salary?.to

        if let from, let to {
            return "\(from.value)-\(to.value) \(from.currency.textSymbol)"
        } else if let from {
            return "от \(from.value) \(from.currency.textSymbol)"
        } else if let to {
            return "до \(to.value) \(to.currency.textSymbol)"
        } else {
            return nil
        }
    }


    private func formatAttributes(_ vacancy: Vacancy) -> String {
        var attributes: [String] = []

        if let employmentType = vacancy.employmentType {
            attributes.append(employmentType.text)
        }

        attributes.append(
            contentsOf: vacancy.schedule.map { value in
                value.text
            }
        )

        if let businessTrip = vacancy.businessTrip {
            attributes.append(businessTrip.vacancyText)
        }

        return attributes.joined(separator: ", ").capitalizingFirstLetter()
    }

}
