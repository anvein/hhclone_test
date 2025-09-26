import SwiftUI

struct SkeletonModifier: ViewModifier {
    let isLoading: Bool
    var color: Color = .Shimmer.textWhite1
    var cornerRadius: CGFloat = 5
    let width: CGFloat?
    let height: CGFloat?

    func body(content: Content) -> some View {
        if isLoading {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .frame(width: width, height: height)
        } else {
            content
        }
    }
}

extension View {
    func skeleton(
        isLoading: Bool,
        color: Color = .Shimmer.textWhite1,
        cornerRadius: CGFloat = 5,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) -> some View {
        modifier(
            SkeletonModifier(
                isLoading: isLoading,
                color: color,
                cornerRadius: cornerRadius,
                width: width,
                height: height
            )
        )
    }
}
