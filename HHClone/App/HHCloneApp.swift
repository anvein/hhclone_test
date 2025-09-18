import SwiftUI
import UIKit

@main
struct HHCloneApp: App {
    @StateObject private var diContainer = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(diContainer)
        }
    }
}
