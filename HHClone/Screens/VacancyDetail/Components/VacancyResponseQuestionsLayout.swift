import SwiftUI

struct VacancyResponseQuestionsLayout: Layout {
    let horizontalSpacing: CGFloat = 12
    let verticalSpacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }

        let maxWidth = proposal.width ?? .greatestFiniteMagnitude

        var currentLineWidth: CGFloat = 0
        var totalHeight: CGFloat = 0
        var maxHeightInLine: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(
                ProposedViewSize(width: proposal.width, height: nil)
            )
            maxHeightInLine = max(maxHeightInLine, size.height)
            let currentHorizontalSpacing = currentLineWidth > 0 ? horizontalSpacing : 0

            if currentLineWidth + size.width + currentHorizontalSpacing > maxWidth {
                totalHeight += maxHeightInLine + verticalSpacing
                currentLineWidth = 0
                maxHeightInLine = size.height
            }

            currentLineWidth += size.width + currentHorizontalSpacing
        }

        totalHeight += maxHeightInLine

        return CGSize(
            width: maxWidth == .greatestFiniteMagnitude ? currentLineWidth : maxWidth,
            height: totalHeight
        )
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let maxWidth = bounds.width
        var x: CGFloat = bounds.minX
        var y: CGFloat = bounds.minY
        var maxHeightInLine: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(
                ProposedViewSize(width: maxWidth, height: nil)
            )

            if x + size.width > maxWidth {
                x = bounds.minX
                y += maxHeightInLine + verticalSpacing
                maxHeightInLine = 0
            }

            subview.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))

            x += size.width + horizontalSpacing
            maxHeightInLine = max(maxHeightInLine, size.height)
        }
    }
}


#Preview() {
    VacancyResponseQuestionsLayout {
        ForEach(VacancyResponseTemplate.allCases, id: \.text) { item in
            Button(item.text) {
                print("tap \(Int.random(in: 0...10))")
            }
            .buttonStyle(VacancyResponseQuestionButtonStyle())
        }
    }
    .background(Color.grey5)
}
