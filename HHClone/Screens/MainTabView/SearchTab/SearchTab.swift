import SwiftUI

struct SearchTab: View {
    @State private var path: [SearchTabRoute] = []
    @EnvironmentObject private var di: AppDIContainer

    var body: some View {
        NavigationStack(path: $path) {
            SearchVacancyScreen(path: $path, vacancyService: di.vacancyService)
                .background(AppColor.bgMain.suiColor)
                .navigationDestination(for: SearchTabRoute.self) { route in
                    switch route {
                    case .vacancyDetail(let vacancyId):
                        VacancyDetailScreen(
                            viewModel: .init(vacancyId: vacancyId)
                        )

                    default:
                        EmptyView()
                    }
                }
        }
        .tint(Color.Text.main)
    }

}
