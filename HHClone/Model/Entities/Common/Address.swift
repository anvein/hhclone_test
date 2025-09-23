struct Address: Hashable {
    let city: String
    let street: String
    let number: String

    var fullAddress: String {
        "\(city), ул. \(street), \(number)"
    }

    static func map(from apiDto: AddressApiDto) -> Self {
        .init(city: apiDto.town, street: apiDto.street, number: apiDto.house)
    }
}
