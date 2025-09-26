import SwiftUI

extension View {
    @ViewBuilder
    func applyIf<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    func frame(size: CGFloat, alignment: Alignment = .center) -> some View {
        self.frame(width: size, height: size, alignment: alignment)
    }

    func shimmeringWhiteSoft(active: Bool, opacity: Double = 0.4) -> some View {
        self.shimmering(
            gradient: .init(colors: [.clear, .white.opacity(opacity), .clear]),
            bandSize: 2,
            mode: .overlay(blendMode: .softLight)
        )
    }
}
