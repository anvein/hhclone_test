import SwiftUI

struct ContentView: View {

    @State private var isLoggedIn: Bool = false

    @State private var path: [Route] = []

    var body: some View {
        if isLoggedIn {
            MainTabView()
        } else {
            NavigationStack(path: $path) {
                LoginScreen(path: $path)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .loginCodeScreen(let model):
                            LoginCodeScreen(path: $path, model: model)
                        default:
                            EmptyView()
                        }
                    }
            }
        }
    }
}

enum Route: Hashable {
    case loginScreen
    case loginCodeScreen(LoginCodeScreenModel)
}

#Preview {
    ContentView()
}
