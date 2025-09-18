import SwiftUI

struct ClipRoundedRectangleModifier: ViewModifier {
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

extension View {
    func clipRoundedRectangle(cornerRadius: CGFloat) -> some View {
        self.modifier(
            ClipRoundedRectangleModifier(cornerRadius: cornerRadius)
        )
    }
}
