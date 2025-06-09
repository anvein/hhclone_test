import SwiftUI

extension FontConvertible {
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
    func suiFont(size: CGFloat) -> SwiftUI.Font {
        return swiftUIFont(size: size)
    }
}
