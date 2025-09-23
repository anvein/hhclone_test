struct Salary: Hashable {
    let value: Int
    let currency: Currency

    static func map(from apiDtoValue: SalaryValueApiDto) -> Self? {
        guard let currencyResult = Currency.map(from: apiDtoValue.currency) else { return nil }

        return .init(
            value: apiDtoValue.value,
            currency: currencyResult
        )
    }
}
