struct VacancyListResponseDto: ApiResponseDto {
    let items: [VacancyItemResponseDto]
    let page: Int
    let totalPages: Int?
}
