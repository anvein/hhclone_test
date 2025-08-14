import SwiftUI

enum SearchVacancyScreenAction: String, CaseIterable {
    case nearVacancies
    case raiseResumeInSearch
    case temporaryWork

    var icon: ImageAsset {
        switch self {
        case .nearVacancies: return AppImage.Icons.geotag
        case .raiseResumeInSearch: return AppImage.Icons.star
        case .temporaryWork: return AppImage.Icons.list
        }
    }

    var title: String {
        switch self {
        case .nearVacancies: return "Вакансии рядом с вами"
        case .raiseResumeInSearch: return "Поднять резюме в поиске"
        case .temporaryWork: return "Временная работа и подработка"
        }
    }

    var iconBgColor: Color {
        switch self {
        case .nearVacancies: return AppColor.Icons.bgBlue.suiColor
        case .raiseResumeInSearch: return AppColor.Icons.bgGreen.suiColor
        case .temporaryWork: return AppColor.Icons.bgGreen.suiColor
        }
    }

    var iconColor: Color {
        switch self {
        case .nearVacancies: return AppColor.Icons.iconBlue.suiColor
        case .raiseResumeInSearch: return AppColor.Icons.iconGreen.suiColor
        case .temporaryWork: return AppColor.Icons.iconGreen.suiColor
        }
    }

    var actionTitle: String? {
        switch self {
        case .raiseResumeInSearch: return "Поднять"
        default: return nil
        }
    }
}
