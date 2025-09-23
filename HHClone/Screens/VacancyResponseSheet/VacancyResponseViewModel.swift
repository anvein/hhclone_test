import Foundation

final class VacancyResponseViewModel: ObservableObject, Identifiable {
    let id = UUID()

    private let vacancyId: UUID

    @Published var vacancyTitle: String

    @Published var isLoading: Bool = false
    @Published var isAddingCoverLetter: Bool = false
    @Published var coverLetterText: String = ""

    @Published var shouldClose = false

    init(vacancyId: UUID, title: String, coverLetterText: String? = nil) {
        self.vacancyId = vacancyId
        self.vacancyTitle = title
        self.coverLetterText = coverLetterText ?? ""
    }

    // MARK: - UI interactions

    func sendResponse() {
        isLoading = true
        Task {
            // показать лоадер
            try? await Task.sleep(nanoseconds: 2_000_000_000) // TODO: УДАЛИТЬ, КОД ДЛЯ РАЗРАБОТКИ

            print("Отклик на вакансию \(vacancyTitle) отправлен")

            await MainActor.run { [weak self] in
                self?.isLoading = false
                self?.shouldClose = true
            }
        }
    }


}
