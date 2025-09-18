struct SalaryRange: Hashable {
    let from: Salary?
    let to: Salary?

    static func map(from apiDto: SalaryApiDto) -> Self? {
        let fromResult = apiDto.from.flatMap(Salary.map(from:))
        let toResult = apiDto.to.flatMap(Salary.map(from:))

        return .init(from: fromResult, to: toResult)
    }
}
