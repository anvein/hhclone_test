import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @AppStorage(DefaultsKeys.isLoggedIn.rawValue) private var isLoggedIn: Bool = false

    var body: some View {
        TabView(selection: $selectedTab) {
            SearchTab()
                .tabItem {
                    Image(uiImage: AppImage.Icons.search.image)
                    Text("Поиск")
                }
                .tag(0)

            Text("Избранное")
                .tabItem {
                    Image(uiImage: AppImage.Icons.heart.image)
                    Text("Избранное")
                }
                .tag(1)

            Text("Отклики")
                .tabItem {
                    Image(uiImage: AppImage.Icons.envelop.image)
                    Text("Отклики")
                }
                .tag(2)

            Text("Сообщения")
                .tabItem {
                    Image(uiImage: AppImage.Icons.messages.image)
                    Text("Сообщения")
                }
                .tag(3)

            VStack {
                Button {
                    isLoggedIn = false
                } label: {
                    Text("Выйти")
                        .padding(10)
                }
            }
            .tabItem {
                Image(uiImage: AppImage.Icons.person.image)
                Text("Профиль")
            }
            .tag(4)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .tint(Color.Text.accentBlue)

    }

}


// MARK: - Preview

struct MainTabView_Previews: PreviewProvider {
    struct Container: View {
        @StateObject private var diContainer = AppDIContainer()

        var body: some View {
            MainTabView()
                .environmentObject(diContainer)
        }
    }

    static var previews: some View {
        Container()
    }
}
