struct SalaryApiDto: Codable {
    let from: SalaryValueApiDto?
    let to: SalaryValueApiDto?
}


struct SalaryValueApiDto: Codable {
    let value: Int
    let currency: String
}

