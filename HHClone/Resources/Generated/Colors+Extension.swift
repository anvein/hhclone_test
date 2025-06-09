import SwiftUI

typealias AppColor = AssetColors.Colors

extension ColorAsset {
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
    internal var suiColor: SwiftUI.Color {
        get {
            swiftUIColor
        }
    }
}
