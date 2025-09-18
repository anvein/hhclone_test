import SwiftUI

enum SearchVacancyScreenAction: String, CaseIterable, HorizontalActionItem {
    case nearVacancies
    case raiseResumeInSearch
    case temporaryWork

    var id: String {
        self.rawValue
    }

    var icon: HorizontalActionIcon {
        .init(asset: iconAsset, color: iconColor, bgColor: iconBgColor)
    }

    var title: String {
        switch self {
        case .nearVacancies: return "Вакансии рядом с вами"
        case .raiseResumeInSearch: return "Поднять резюме в поиске"
        case .temporaryWork: return "Временная работа и подработка"
        }
    }

    var actionTitle: String? {
        switch self {
        case .raiseResumeInSearch: return "Поднять"
        default: return nil
        }
    }

    private var iconAsset: ImageAsset {
        switch self {
        case .nearVacancies: return AppImage.Icons.geotag
        case .raiseResumeInSearch: return AppImage.Icons.star
        case .temporaryWork: return AppImage.Icons.list
        }
    }

    private var iconColor: Color {
        switch self {
        case .nearVacancies: return AppColor.Icons.iconBlue.suiColor
        case .raiseResumeInSearch: return AppColor.Icons.iconGreen.suiColor
        case .temporaryWork: return AppColor.Icons.iconGreen.suiColor
        }
    }

    private var iconBgColor: Color {
        switch self {
        case .nearVacancies: return AppColor.Icons.bgBlue.suiColor
        case .raiseResumeInSearch: return AppColor.Icons.bgGreen.suiColor
        case .temporaryWork: return AppColor.Icons.bgGreen.suiColor
        }
    }

}
