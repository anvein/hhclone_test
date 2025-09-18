enum VacancyListSortTypeApiDto: String {
    case search
    case date
    case distance
    case salaryDesc = "salary_desc"
    case salaryAsc = "salary_acs"
}

extension VacancyListSortType {
    func toApiDto() -> VacancyListSortTypeApiDto {
        switch self {
        case .bySearch: .search
        case .byDate: .date
        case .byDistance: .distance
        case .bySalaryDesc: .salaryDesc
        case .bySalaryAsc: .salaryAsc
        }
    }
}
