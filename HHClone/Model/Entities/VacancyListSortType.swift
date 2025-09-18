enum VacancyListSortType: String, CaseIterable {
    case bySearch
    case byDate
    case byDistance
    case bySalaryDesc
    case bySalaryAsc

    static var defaultValue: Self {
        .bySearch
    }
}
