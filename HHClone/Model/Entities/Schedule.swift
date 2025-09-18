enum Schedule {
    case fullDay
    case shiftSchedule
    case flexibleSchedule
    case remote
    case rotationWork

    var text: String {
        switch self {
        case .fullDay: "полный день"
        case .shiftSchedule: "сменный график"
        case .flexibleSchedule: "гибкий график"
        case .remote: "удаленная работа"
        case .rotationWork: "вахтовый метод"
        }
    }

    static func map(from apiDtoValue: String) -> Self? {
        switch apiDtoValue {
        case "fullDay": Self.fullDay
        case "shiftSchedule": Self.shiftSchedule
        case "flexibleSchedule": Self.flexibleSchedule
        case "remote": Self.remote
        case "rotationWork": Self.rotationWork
        default: nil
        }
    }
}
