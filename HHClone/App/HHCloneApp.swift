import SwiftUI
import UIKit
import YandexMapsMobile

@main
struct HHCloneApp: App {
    @StateObject private var diContainer = AppDIContainer()

    init() {
        YMKMapKit.setApiKey("06b99846-9da0-43bc-a56c-4e43d31eb071")
        YMKMapKit.sharedInstance()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(diContainer)
                .onAppear {

                }
        }
    }
}
