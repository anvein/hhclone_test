import Foundation

struct VacancyListResponseDto: ApiResponseDto {
    let items: [VacancyItemResponseDto]
    let page: Int
    let totalPages: Int?
}

struct VacancyItemResponseDto: Decodable {
    let id: UUID
    let title: String
    let address: AddressApiDto
    let company: String
    let isCompanyVerify: Bool
    let experience: String
    let publishedDate: Date
    let isFavorite: Bool
    let salary: SalaryApiDto?
    let schedules: [String]
    let description: String?
    let responsibilities: String?
    let employmentType: String
    let businessTrip: String
    let questions: [String]

    let lookingNumber: Int?
    let appliedNumber: Int?
}
