import SwiftUI

struct ContentView: View {

    @AppStorage(DefaultsKeys.isLoggedIn.rawValue) private var isLoggedIn: Bool = false
    @State private var path: [Route] = []

    var body: some View {
        Group {
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
        .transition(.move(edge: .trailing))
        .animation(.linear(duration: 0.4), value: isLoggedIn)
    }
}

enum Route: Hashable {
    case loginScreen
    case loginCodeScreen(LoginCodeScreenModel)
}

// MARK: - Preview

#Preview {
    ContentView()
}
