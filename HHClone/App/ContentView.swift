import SwiftUI
import UIKit

struct ContentView: View {
    @AppStorage(DefaultsKeys.isLoggedIn.rawValue) private var isLoggedIn: Bool = false

    init() {
        configureTabBar()
        configureScrollView()
        configureNavigationBar()
    }

    var body: some View {
        Group {
            if isLoggedIn {
                MainTabView()
            } else {
                AuthNavigationStackView()
            }
        }
    }

    // MARK: - UI global configure

    private func configureTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .bgMain

        let lineImage = UIImage(
            color: AppColor.TabBar.separator.color,
            size: CGSize(width: 1, height: 1)
        )
        appearance.shadowImage = lineImage
        appearance.backgroundImage = UIImage()

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance

        UITabBar.appearance().unselectedItemTintColor = AppColor.grey4.color
    }

    private func configureScrollView() {
        UIScrollView.appearance().indicatorStyle = .default
        UIScrollView.appearance().delaysContentTouches = false
    }

    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()

        appearance.backgroundColor = .clear
        appearance.backgroundColor = UIColor(Color.bgMain)

        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage(
            color: .clear,
            size: CGSize(width: 1, height: 1)
        )

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(Color.Text.main)
        ]

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.Text.main)
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance

        UINavigationBar.appearance().tintColor = UIColor(Color.Text.main)
    }

}

// MARK: - Preview

//#Preview {
//    ContentView()
//}

//struct VacancyDetailScreen2_Previews: PreviewProvider {
//
//    struct Container: View {
//        @State private var path = [String]()
//
//        var body: some View {
//            NavigationStack(path: $path) {
//                EmptyView()
//                    .navigationDestination(for: String.self) { view in
//                        VacancyDetailScreen
//                            .toolbarTitleDisplayMode(.inline)
//                    }
//                    .onAppear {
//                        path.append("VacancyDetail")
//                    }
//            }
//        }
//    }
//
//    static var previews: some View {
//        Container()
//    }
//
//}
