final class VacancyMapper {
    func map(from vacanciesApiDto: [VacancyItemResponseDto]) -> [Vacancy] {
        vacanciesApiDto.map { apiDto in
            map(from: apiDto)
        }
    }

    func map(from apiDto: VacancyItemResponseDto) -> Vacancy {
        return .init(
            id: apiDto.id,
            title: apiDto.title,
            descriptionMarkdownContent: apiDto.description,
            responsibilitiesMarkdownContent: apiDto.responsibilities,
            address: Address.map(from: apiDto.address),
            locationPoint: nil,
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

    private func mapScheduleField(from apiDtoValues: [String]) -> Set<Schedule> {
        Set(apiDtoValues.compactMap { Schedule.map(from: $0) })
    }
}
