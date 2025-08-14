import SwiftUI

struct SearchVacancyActionsRowView: View {
    var onTap: ((SearchVacancyScreenAction) -> Void)?

    @State private var pressedActionId: SearchVacancyScreenAction? = nil

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEach(SearchVacancyScreenAction.allCases, id: \.self) { item in
                    VStack(alignment: .leading, spacing: 0) {
                        Image(asset: item.icon)
                            .padding(.all, 4)
                            .background(
                                Circle()
                                    .fill(item.iconBgColor)
                            )

                        Text(item.title)
                            .padding(.top, 16)
                            .font(TextStyle.title14)
                            .foregroundStyle(AppColor.Text.main.suiColor)
                            .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 4)

                        if let actionTitle = item.actionTitle {
                            Text(actionTitle)
                                .foregroundStyle(item.iconColor)
                                .font(TextStyle.text14)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 10)
                    .frame(width: 132, height: 120, alignment: .topLeading)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(AppColor.bgSecondary.suiColor)
                    )
                    .padding(.vertical, 20)
                    .scaleEffect(pressedActionId == item ? 0.96 : 1.0)
                    .animation(.easeInOut(duration: 0.1), value: pressedActionId)
                    .onTapGesture {
                        onTap?(item)
                    }
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 3)
                            .onChanged { _ in
                                pressedActionId = nil
                            }
                    )
                    .onLongPressGesture(
                        minimumDuration: 0,
                        maximumDistance: 3,
                        pressing: { isPressing in
                            pressedActionId = isPressing ? item : nil
                        },
                        perform: {}
                    )
                }
            }
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.hidden, axes: [.horizontal])
        .frame(maxWidth: .infinity, minHeight: 120, maxHeight: 120)
    }

}

// MARK: - Preview

#Preview {
    SearchVacancyActionsRowView(onTap: nil)
        .padding(.vertical, 100)
        .background(.black)
}
