import Foundation
import YandexMapsMobile

struct VacancyDetailViewData {
    var id: UUID
    var isFavourite: Bool
    var title: String
    let descriptionMarkdownContent: String?
    let address: String
    let locationPoint: YMKPoint?
    let employerTitle: String
    let isEmployerVerify: Bool
    let experience: String?
    let publishedAt: String?
    let salary: String?
    let attributes: String

    let responsesCount: Int
    let visitorsNow: Int
}
