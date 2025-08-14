struct Address: Hashable {
    let city: String
    let street: String
    let number: String

    var fullAddress: String {
        "\(city), ул. \(street), \(number)"
    }
}
