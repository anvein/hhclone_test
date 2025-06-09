import SwiftUI
import UIKit

@main
struct HHCloneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    init() {
        UITabBar.appearance().unselectedItemTintColor = AppColor.Text.grey.color
//        UITextField.appearance().tintColor = .white
    }
}
