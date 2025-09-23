enum BusinessTripType {
    case ready
    case readyRarely
    case notReady

    var vacancyText: String {
        switch self {
        case .ready: "частые командировки"
        case .readyRarely: "редкие командировки"
        case .notReady: "без командировок"
        }
    }

    var resumeText: String {
        switch self {
        case .ready: "готов к командировкам"
        case .readyRarely: "готов к редким командировкам"
        case .notReady: "не готов к командировкам"
        }
    }

    static func map(from apiDtoValue: String) -> Self? {
        switch apiDtoValue {
        case "ready": Self.ready
        case "readyRarely": Self.readyRarely
        case "notReady": Self.notReady
        default: nil
        }
    }
}
