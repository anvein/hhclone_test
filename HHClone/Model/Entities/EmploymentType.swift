enum EmploymentType {
    case full
    case partiall
    case projectWork
    case volunttering
    case internship

    var text: String {
        switch self {
        case .full: "полная занятость"
        case .partiall: "частичная занятость"
        case .projectWork: "проектная работа"
        case .volunttering: "волонтерство"
        case .internship: "стажировка"
        }
    }

    static func map(from apiDtoValue: String) -> Self? {
        switch apiDtoValue {
        case "full": Self.full
        case "partiall": Self.partiall
        case "projectWork": Self.projectWork
        case "voluntteing": Self.volunttering
        case "internship": Self.internship
        default: nil
        }
    }
}
