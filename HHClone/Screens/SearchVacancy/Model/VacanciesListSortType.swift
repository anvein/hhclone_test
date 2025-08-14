enum VacanciesListSortType: String, CaseIterable {
    case bySearch
    case byDate
    case byDistance
    case bySalaryDesc
    case bySalaryAsc

    var title: String {
        switch self {
        case .bySearch: "По соответствию"
        case .byDate: "По дате"
        case .byDistance: "По удаленности"
        case .bySalaryDesc: "По убыванию дохода"
        case .bySalaryAsc:  "По возрастанию дохода"
        }
    }

    var imageSystemName: String {
        switch self {
        case .bySearch: "text.page.badge.magnifyingglass"
        case .byDate: "calendar"
        case .byDistance: "location"
        case .bySalaryDesc: "chart.line.downtrend.xyaxis"
        case .bySalaryAsc: "chart.line.uptrend.xyaxis"
        }
    }

}
