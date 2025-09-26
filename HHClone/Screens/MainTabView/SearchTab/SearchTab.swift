import SwiftUI

struct SearchTab: View {
    @State private var path: [SearchTabRoute] = []
    @StateObject private var vacancyListVM: SearchVacancyViewModel

    private var di: AppDIContainer

    var body: some View {
        NavigationStack(path: $path) {
            SearchVacancyScreen(
                path: $path,
                viewModel: vacancyListVM
            )
            .background(AppColor.bgMain.suiColor)
            .navigationDestination(for: SearchTabRoute.self) { route in
                switch route {
                case .vacancyDetail(let vacancyId):
                    VacancyDetailScreen(
                        viewModel: .init(
                            vacancyService: di.vacancyService,
                            vacancyId: vacancyId
                        ) { vacancy in
                            self.vacancyListVM.updateVacancyData(vacancy)
                        }
                    )

                default:
                    EmptyView()
                }
            }
        }
        .tint(Color.Text.main)
    }

    init(di: AppDIContainer) {
        self.di = di
        self._vacancyListVM = StateObject(
            wrappedValue: .init(vacancyService: di.vacancyService)
        )
    }

}
