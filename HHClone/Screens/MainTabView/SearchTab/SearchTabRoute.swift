import Foundation

enum SearchTabRoute: Hashable {
    case searchVacancy
    case vacancyDetail(vacancyId: UUID)
}
