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
}
