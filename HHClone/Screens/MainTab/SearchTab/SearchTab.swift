import SwiftUI

struct SearchTab: View {
    @State private var path: [SearchTabRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            SearchVacancyScreen(path: $path)
                .background(AppColor.bgMain.suiColor)
                .navigationDestination(for: SearchTabRoute.self) { route in
                    switch route {
                    case .vacancyDetail(let vacancy):
                        VacancyDetailScreen(
                            viewModel: .init(vacancyId: vacancy.id)
                        )

                    default:
                        EmptyView()
                    }
                }
        }
        .tint(Color.Text.main)
    }

}
