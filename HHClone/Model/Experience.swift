enum Experience: Hashable {
    case no
    case from1to3years
    case from3to6years
    case from6years

    var text: String {
        switch self {
        case .no: "без опыта"
        case .from1to3years: "от 1 года до 3 лет"
        case .from3to6years: "от 3 до 6 лет"
        case .from6years: "более 6 лет"
        }
    }
}
