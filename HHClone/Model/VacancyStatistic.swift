struct VacancyStatistic: Hashable {
    let responses: Int
    let visitorsNow: Int
}


extension VacancyStatistic {
    static let testModel: Self = .init(responses: 127, visitorsNow: 2)
}
