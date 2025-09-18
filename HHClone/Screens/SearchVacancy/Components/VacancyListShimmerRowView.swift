import SwiftUI

struct VacancyListShimmerRowView: View {

    @State private var width: CGFloat = .zero

    var body: some View {
        contentView
            .frame(maxWidth: .infinity)
            .getContentSize(width: $width)
            .padding(.all, 16)
            .background(AppColor.bgSecondary.suiColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                Color.clear
                    .frame(maxWidth: .infinity)
                    .shimmering(
                        gradient: .init(colors: [.clear, .white.opacity(0.2), .clear]),
                        bandSize: 2,
                        mode: .overlay(blendMode: .softLight)
                    )
                    .mask(contentView)
                    .padding(.all, 16)

            }
    }

    private var contentView: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(spacing: 16) {
                    Group {

                        ShimmerRectangle(color: Color.Shimmer.textGreen1)
                            .frame(width: width * 0.6, height: 14)

                        ShimmerRectangle()
                            .frame(width: width * 0.75, height: 16)

                        ShimmerRectangle()
                            .frame(width: width * 0.4, height: 16)

                        VStack(spacing: 10) {
                            ShimmerRectangle()
                                .frame(width: width * 0.3, height: 12)

                            ShimmerRectangle()
                                .frame(width: width * 0.3, height: 12)
                        }

                        ShimmerRectangle()
                            .frame(width: width * 0.45, height: 12)

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                VStack {
                    ShimmerRectangle()
                        .frame(width: 24, height: 24)
                }
            }

            ShimmerRectangle(color: .Shimmer.textGreen1)
                .frame(maxWidth: .infinity, minHeight: 32, maxHeight: 32)
                .padding(.top, 10)

        }
    }

}

// MARK: - Preview

#if DEBUG
#Preview {
    ZStack(alignment: .top) {
        Color.black
        VacancyListShimmerRowView()

        //        VacancyListRowView(vacancy: .constant(.init(vacancy: Vacancy.testVacancy)))
//                    .opacity(0.2)
    }
}
#endif
