import SwiftUI

struct ShimmerRectangle: View {
    let color: Color
    let cornerRadius: CGFloat

    init(
        color: Color = Color.Shimmer.textWhite1,
        cornerRadius: CGFloat = 5
    ) {
        self.color = color
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        color
            .clipRoundedRectangle(cornerRadius: cornerRadius)
    }
}
