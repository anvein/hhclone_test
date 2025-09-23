import Foundation
import SwiftUI

class VacancyRowViewModel: Identifiable, ObservableObject {
    let id: UUID
    @Published var isFavourite: Bool
    @Published var title: String
    @Published var experienceText: String?
    @Published var salaryRangeText: String?

    @Published var employerTitle: String
    @Published var employerCity: String
    @Published var isEmployerVerify: Bool

    @Published var publishedAtText: String
    @Published var viewersNowText: String

    @Published var isUpdating: Bool = false

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

    func update(from vacancy: Vacancy) {
        isFavourite = vacancy.isFavourite
        title = vacancy.title
        experienceText = Self.prepareExperienceText(vacancy.experience)

        // TODO: дописать
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
