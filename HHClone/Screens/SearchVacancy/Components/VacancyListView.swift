import SwiftUI

struct VacancyListView: View {
    @Binding var vacancies: [VacancyRowViewModel]
    @State private var pressedVacancyId: UUID? = nil
    var isLoading: Bool

    var onTapAddToFavourite: (VacancyRowViewModel) -> Void
    var onTapRespond: (VacancyRowViewModel) -> Void
    var onTapVacancy: (VacancyRowViewModel) -> Void

    var body: some View {
        ForEach($vacancies) { $vacancy in
            VacancyListRowView(vacancy: $vacancy) {
                // TODO: возможно захватывать id а не всю структуру
                onTapAddToFavourite(vacancy)
            } onTapApplyToVacancy: {
                onTapRespond(vacancy)
            }
            .padding(.bottom, 8)
            .scaleEffect(pressedVacancyId == vacancy.id ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: pressedVacancyId)
            .contentShape(Rectangle())
            .onTapGesture {
                // TODO: возможно захватывать id а не всю структуру
                onTapVacancy(vacancy)
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 3)
                    .onChanged { _ in
                        pressedVacancyId = nil
                    }
            )
            .onLongPressGesture(
                minimumDuration: 0,
                maximumDistance: 3,
                pressing: { isPressing in
                    pressedVacancyId = isPressing ? vacancy.id : nil
                },
                perform: {}
            )
        }

        if isLoading {
            ShimmerList(itemsCount: 5)
        } else {
            Color.clear
                .frame(height: 1)
                .preference(key: ShowBottomItemPreferenceKey.self, value: true)
        }
    }

}

// MARK: - Subviews

fileprivate struct ShimmerList: View {
    let itemsCount: Int

    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<itemsCount, id: \.self) { _ in
                VacancyListShimmerRowView()
            }
        }
    }
}
