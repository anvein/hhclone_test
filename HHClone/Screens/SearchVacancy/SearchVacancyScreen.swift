import SwiftUI

// MARK: - Main view

struct SearchVacancyScreen: View {

    @Binding private var path: [SearchTabRoute]

    @State private var vacancies: [Vacancy] = Vacancy.mockList

    private var sortTypes: [VacanciesListSortType] = VacanciesListSortType.allCases
    @State private var selectedSortType: VacanciesListSortType? = .allCases.first

    var body: some View {
        ZStack {
            Color(uiColor: AppColor.bgMain.color)

            ScrollView {

                SearchVacancyActionsRowView(onTap: { action in
                    handleTapAction(action)
                })
                .padding(.vertical, 20)

                LazyVStack(alignment: .leading, spacing: 0) {
                    VacancyListHeaderView(
                        vacanciesCount: 153,
                        sortTypes: sortTypes,
                        selectedSortType: $selectedSortType
                    )

                    VacancyListView(
                        vacancies: $vacancies
                    ) { vacancy in
                        handleTapAddToFavourite(vacancy)
                    } onTapRespond: { vacancy in
                        handleTapApplyTo(vacancy)
                    } onTapVacancy: { vacancy in
                        path.append(.vacancyDetail(vacancy))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 30)
            }
            .scrollContentBackground(.hidden)
            .padding(.init(top: 1, leading: 0, bottom: 1, trailing: 0))
            .onAppear(perform: {
                selectedSortType = sortTypes.first
            })
        }
    }

    // MARK: - Init

    init(path: Binding<[SearchTabRoute]>) {
        self._path = path
    }

    // MARK: - Action Handlers

    private func handleTapAction(_ action: SearchVacancyScreenAction) {
        print("on tap action: \(action.rawValue)")
    }

    private func handleTapAddToFavourite(_ vacancy: Vacancy) {
        print("on tap Add To Favourite Vacancy \(vacancy.title)")

        guard let vacancyIndex = vacancies.firstIndex(where: { $0.id == vacancy.id }) else {
            return
        }

        DispatchQueue.main.async {
            withAnimation(nil) {
                vacancies[vacancyIndex].isFavourite.toggle()
            }
        }
    }

    private func handleTapApplyTo(_ vacancy: Vacancy) {
        print("on tap Apply To Vacancy \(vacancy.title)")
    }
}

// MARK: - Subviews

fileprivate struct VacancyListHeaderView: View {
    let vacanciesCount: Int
    let sortTypes: [VacanciesListSortType]
    @Binding var selectedSortType: VacanciesListSortType?

    var body: some View {
        ListSectionTitleRow("Вакансии для вас")
            .padding(.bottom, 8)

        ListSortWithMenuRow<String>(
            "\(vacanciesCount) вакансий",
            values: sortTypes.map {
                .init(
                    key: $0.rawValue,
                    title: $0.title,
                    image: .systemImage($0.imageSystemName)
                )
            },
            selectedValue: Binding(
                get: {
                    selectedSortType?.rawValue
                }, set: { newValue in
                    if let newValue {
                        selectedSortType = sortTypes.first(where: { item in
                            item.rawValue == newValue
                        })
                    } else {
                        selectedSortType = nil
                    }
                }
            )
        )
        .padding(.vertical, 10)
    }
}

fileprivate struct VacancyListView: View {
    @Binding var vacancies: [Vacancy]
    @State private var pressedVacancyId: UUID? = nil

    var onTapAddToFavourite: (Vacancy) -> Void
    var onTapRespond: (Vacancy) -> Void
    var onTapVacancy: (Vacancy) -> Void

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
    }

}

// MARK: - Preview

#Preview {
    MainTabView()
        .previewLayout(.fixed(width: 300, height: 600))
}
