import Foundation

struct VacancyDetailViewData {
    var id: UUID
    var isFavourite: Bool
    var title: String
    let descriptionMarkdownContent: String
    let address: String
    let locationPoint: MapPoint
    let employerTitle: String
    let isEmployerVerify: Bool
    let experience: String?
    let publishedAt: String?
    let salary: String
    let attributes: String

    let responsesCount: Int
    let visitorsNow: Int

//    var salaryRangeText: String? { // TODO: вынести из VM
//        let from = salary?.from
//        let to = salary?.to
//
//        if let from, let to {
//            return "\(from.value)-\(to.value) \(from.currency.textSymbol)"
//        } else if let from {
//            return "от \(from.value) \(from.currency.textSymbol)"
//        } else if let to {
//            return "до \(to.value) \(to.currency.textSymbol)"
//        } else {
//            return nil
//        }
//    }
}
