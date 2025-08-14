import SwiftUI

struct AuthNavigationStackView: View {
    @State private var path: [AuthRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            LoginScreen(path: $path)
                .navigationDestination(for: AuthRoute.self) { route in
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

