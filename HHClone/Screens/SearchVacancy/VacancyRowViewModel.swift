import Foundation

struct VacancyRowViewModel: Identifiable {
    let id: UUID
    var isFavourite: Bool
    let title: String
    let experienceText: String?
    let salaryRangeText: String?

    let employerTitle: String
    let employerCity: String
    let isEmployerVerify: Bool

    let publishedAtText: String
    let viewersNowText: String

    init(vacancy: Vacancy/*, listVM: SearchVacancyViewModel*/) {
        self.id = vacancy.id
        self.isFavourite = vacancy.isFavourite
        self.title = vacancy.title
        self.experienceText = Self.prepareExperienceText(vacancy.experience)
        self.salaryRangeText = Self.prepareSalaryRangeText(vacancy.salary)

        self.employerTitle = vacancy.employerTitle
        self.employerCity = vacancy.address.city
        self.isEmployerVerify = vacancy.isEmployerVerify

        // TODO: 
        self.publishedAtText = "Опубликовано 14 февраля"
        self.viewersNowText = "Сейчас просматривает 1 человек"
    }

    // MARK: - Prepare data

    private static func prepareExperienceText(_ experience: Experience?) -> String? {
        guard let experience else { return nil }

        if experience == .no {
            return experience.text.capitalizingFirstLetter()
        } else {
            return "Опыт \(experience.text)"
        }
    }

    private static func prepareSalaryRangeText(_ salary: SalaryRange?) -> String? {
        guard let salary else { return nil }

        let from = salary.from
        let to = salary.to

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
}
