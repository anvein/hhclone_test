import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @AppStorage(DefaultsKeys.isLoggedIn.rawValue) private var isLoggedIn: Bool = false

    var body: some View {
        TabView(selection: $selectedTab) {

        Text("Поиск")
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(0)

            Text("Избранное")
                .tabItem {
                    Label("Избранное", systemImage: "suit.heart")
                }
                .tag(1)

            Text("Отклики")
                .tabItem {
                    Image(systemName: "envelope")
                    Text("Отклики")
                }
                .tag(2)

            Text("Сообщения")
                .tabItem {
                    Image(systemName: "message")
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
                Image(systemName: "person.fill")
                Text("Профиль")
            }
            .tag(4)
        }
        .tint(AppColor.blueAccent.suiColor)
    }
}

#Preview {
    MainTabView()
}


