enum Currency: Hashable {
    case rub
    case usd
    case kzt
    case byn

    var textSymbol: String {
        switch self {
        case .rub: "₽"
        case .usd: "$"
        case .kzt: "Kzt"
        case .byn: "Br"
        }
    }

    static func map(from apiDtoValue: String) -> Self? {
        switch apiDtoValue {
        case "rub": Self.rub
        case "usd": Self.usd
        case "kzt": Self.kzt
        case "byn": Self.byn
        default: nil
        }
    }
}
