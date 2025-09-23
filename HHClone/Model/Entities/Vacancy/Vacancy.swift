import Foundation

struct Vacancy: Identifiable, Hashable {
    var id: UUID = UUID()
    var isFavourite: Bool = false
    var title: String
    let descriptionMarkdownContent: String?
    let responsibilitiesMarkdownContent: String?

    // employer
    let address: Address
    let locationPoint: MapPoint?
    let employerTitle: String
    let isEmployerVerify: Bool

    let experience: Experience?
    let publishedAt: Date?
    let salary: SalaryRange?

    let employmentType: EmploymentType?
    var schedule: Set<Schedule> = []
    let businessTrip: BusinessTripType?
    let statistic: VacancyStatistic
}

// MARK: - Test data

extension Vacancy {
    static let mockVacancyUuid = UUID()
    static let testVacancy: Self = .init(
        id: Self.mockVacancyUuid,
        title: "UI/UX Designer",
        descriptionMarkdownContent: """
**MOBYRIX** - динамично развивающаяся продуктовая IT-компания, специализирующаяся на разработке мобильных приложений для iOS и Android. Наша команда работает над собственными продуктами в разнообразных сферах: от утилит до развлечений и бизнес-приложений.
Мы ценим талант и стремление к инновациям и в данный момент в поиске талантливого UX/UI Designer, готового присоединиться к нашей команде и внести значимый вклад в развитие наших проектов.

**Ваши задачи**
- Проектировать пользовательский опыт, проводить UX исследования;
- Разрабатывать адаптивный дизайн интерфейса для мобильных приложений;
- Разрабатывать быстрые прототипы для тестирования идеи дизайна и их последующая; интеграция на основе обратной связи от команды и пользователей;
- Взаимодействовать с командой разработчиков для обеспечения точной реализации ваших дизайнов;
- Анализ пользовательского опыта и адаптация под тренды.
""",
        responsibilitiesMarkdownContent: "<p>Ответственность</p>",
        address: .init(city: "Минск", street: "Бирюзова", number: "4/5"),
        locationPoint: .testPoint,
        employerTitle: "Мобирикс",
        isEmployerVerify: true,
        experience: .from1to3years,
        publishedAt: Date(),
        salary: .init(
            from: Salary(value: 1500, currency: .byn),
            to: Salary(value: 2900, currency: .byn)
        ),
        employmentType: .full,
        schedule: [.fullDay],
        businessTrip: nil,
        statistic: .testModel
    )

    static var mockList = [
        Vacancy(
            id: Vacancy.mockVacancyUuid,
            title: "UI/UX Designer",
            descriptionMarkdownContent: "<p>Хорошая вакансия</p>",
            responsibilitiesMarkdownContent: "<p>Ответственность</p>",
            address: .init(city: "Минск", street: "Бирюзова", number: "4/5"),
            locationPoint: .testPoint,
            employerTitle: "Мобирикс",
            isEmployerVerify: true,
            experience: .from1to3years,
            publishedAt: Date(),
            salary: nil,
            employmentType: .full,
            businessTrip: .ready,
            statistic: .testModel
        ),
        Vacancy(
            title: "Дизайнер для маркетплейсов Wildberries, Ozon",
            descriptionMarkdownContent: "<p>Хорошая вакансия</p>",
            responsibilitiesMarkdownContent: "<p>Ответственность</p>",
            address: .init(city: "Минск", street: "Елизарова", number: "38"),
            locationPoint: .testPoint,
            employerTitle: "Еком дизайн",
            isEmployerVerify: true,
            experience: nil,
            publishedAt: nil,
            salary: .init(
                from: Salary(value: 1500, currency: .byn),
                to: Salary(value: 2900, currency: .byn)
            ),
            employmentType: .partiall,
            businessTrip: .ready,
            statistic: .testModel
        ),
    ] + Array(repeating: Vacancy.testVacancy, count: 10).map({ vacancy in
        var newVacancy = vacancy
        newVacancy.id = UUID()
        newVacancy.title += " \(Int.random(in: 0...10))"
        return newVacancy
    })

}
