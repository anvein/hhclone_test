final class VacancyMapper {
    func map(from vacanciesApiDto: [VacancyItemResponseDto]) -> [Vacancy] {
        vacanciesApiDto.map { apiDto in
            map(from: apiDto)
        }
    }

    func map(from apiDto: VacancyListResponseDto) -> VacancyList {
        return .init(
            vacancies: apiDto.items.map({
                self.map(from: $0)
            }),
            pagination: .init(page: apiDto.page, totalPages: apiDto.totalPages)
        )
    }

    func map(from apiDto: VacancyItemResponseDto) -> Vacancy {
        return .init(
            id: apiDto.id,
            isFavourite: apiDto.isFavorite,
            title: apiDto.title,
            descriptionMarkdownContent: apiDto.description,
            responsibilitiesMarkdownContent: apiDto.responsibilities,
            address: Address.map(from: apiDto.address),
            companyLocation: apiDto.companyLocation.flatMap { MapPoint.map(from: $0) },
            employerTitle: apiDto.company,
            isEmployerVerify: apiDto.isCompanyVerify,
            experience: Experience.map(from: apiDto.experience),
            publishedAt: apiDto.publishedDate,
            salary: apiDto.salary.flatMap { SalaryRange.map(from: $0) },
            employmentType: EmploymentType.map(from: apiDto.employmentType),
            schedule: mapScheduleField(from: apiDto.schedules),
            businessTrip: BusinessTripType.map(from: apiDto.businessTrip) ,
            statistic: .init(
                responses: apiDto.appliedNumber ?? 0,
                visitorsNow: apiDto.lookingNumber ?? 0
            )
        )
    }

    private func mapScheduleField(from apiDtoValues: [String]) -> [Schedule] {
        apiDtoValues.compactMap { Schedule.map(from: $0) }
    }
}
