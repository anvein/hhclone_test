enum EmploymentType {
    case full
    case partiall
    case projectWork
    case voluntteing
    case internship

    var text: String {
        switch self {
        case .full: "полная занятость"
        case .partiall: "частичная занятость занятость"
        case .projectWork: "проектная работа"
        case .voluntteing: "волонтерство"
        case .internship: "стажировка"
        }
    }
}
