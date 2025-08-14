extension VacancyResponseTemplate {
    var text: String {
        switch self {
        case .workLocation:
            return "Где располагается место работы?"
        case .workSchedule:
            return "Какой график работы?"
        case .vacancyAvailability:
            return "Вакансия открыта?"
        case .compensationDetails:
            return "Какая оплата труда?"
        }
    }

    var messageText: String {
        "Здравствуйте! \(self.text)"
    }
}
