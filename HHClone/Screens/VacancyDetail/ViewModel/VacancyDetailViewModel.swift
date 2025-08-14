import SwiftUI
import Foundation

final class VacancyDetailViewModel: ObservableObject {

    private var vacancy: Vacancy

    @Published private(set) var viewData: VacancyDetailViewData?

    @Published var isShowResponseSheet: Bool = false
    @Published var responseCoverLetter: String?
    @Published var responseSheetHeight: CGFloat = VacancyResponseSheet.defaultHeight

    // MARK: - Init

    init(vacancyId: UUID) {
//        loadVacancy(by: vacancyId)
        self.vacancy = Vacancy.testVacancy
        self.viewData = self.makeViewData(from: Vacancy.testVacancy)
    }

    // Инициализатор с готовой моделью
    init(vacancy: Vacancy) {
        self.vacancy = vacancy
        self.viewData = self.makeViewData(from: vacancy)
    }

    // MARK: -

    func resetResponseSheetIfNeeded() {
        if isShowResponseSheet == false {
            responseCoverLetter = nil
            responseSheetHeight = VacancyResponseSheet.defaultHeight
        }
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

    private func formatSalaryRange(_ salary: SalaryRange?) -> String {
        let from = salary?.from
        let to = salary?.to

        if let from, let to {
            return "\(from.value)-\(to.value) \(from.currency.textSymbol)"
        } else if let from {
            return "от \(from.value) \(from.currency.textSymbol)"
        } else if let to {
            return "до \(to.value) \(to.currency.textSymbol)"
        } else {
            return "Уровень дохода не указан"
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
