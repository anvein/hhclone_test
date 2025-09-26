import SwiftUI

// MARK: - Main view

struct SearchVacancyScreen: View {

    @Binding private var path: [SearchTabRoute]

    @ObservedObject private var viewModel: SearchVacancyViewModel

    var body: some View {
        ZStack {
            Color(uiColor: AppColor.bgMain.color)

            ScrollView {
                HorizontalActionsView(items: SearchVacancyScreenAction.allCases) { action in
                    handleTapAction(action)
                }
                .padding(.vertical, 20)

                LazyVStack(alignment: .leading, spacing: 0) {
                    VacancyListHeaderView(
                        vacanciesCount: $viewModel.vacancies.count,
                        sortTypes: viewModel.sortTypes,
                        isLoading: viewModel.isLoading,
                        selectedSortType: $viewModel.selectedSortType
                    )

                    VacancyListView(
                        vacancies: $viewModel.vacancies,
                        isLoading: viewModel.isLoading
                    ) { vacancyId in
                        handleTapAddToFavourite(with: vacancyId)
                    } onTapRespond: { vacancy in
                        handleTapApplyTo(vacancy)
                    } onTapVacancy: { vacancy in
                        path.append(.vacancyDetail(vacancyId: vacancy.id))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 30)
            }
            .scrollContentBackground(.hidden)
            .padding(.init(top: 1, leading: 0, bottom: 1, trailing: 0))
            .refreshable {
                viewModel.reloadVacancies()
            }
            .onAppear() {
                if viewModel.vacancies.isEmpty {
                    viewModel.reloadVacancies()
                }
            }
            .onChange(of: viewModel.selectedSortType) { _, newValue in
                viewModel.reloadVacancies()
            }
            .onPreferenceChange(ShowBottomItemPreferenceKey.self, perform: { isShowBottom in
                guard isShowBottom else { return }
                viewModel.loadNextPageVacanciesIfNeeded()
            })
        }
        .vacancyResponseSheet(
            viewModel: $viewModel.responseSheetViewModel,
            height: $viewModel.responseSheetHeight
        )
    }

    init(
        path: Binding<[SearchTabRoute]>,
        viewModel: SearchVacancyViewModel
    ) {
        self._path = path
        self.viewModel = viewModel
    }

    // MARK: - Action Handlers

    private func handleTapAction(_ action: SearchVacancyScreenAction) {
        print("on tap action: \(action.rawValue)")
    }

    private func handleTapAddToFavourite(with id: UUID) {
        viewModel.toggleIsFavourite(with: id)
    }

    private func handleTapApplyTo(_ vacancy: VacancyRowViewModel) {
        viewModel.showResponseSheet(for: vacancy.id)
    }
}

// MARK: - Subviews

fileprivate struct VacancyListHeaderView: View {
    let vacanciesCount: Int
    let sortTypes: [VacancyListSortType]
    let isLoading: Bool
    @Binding var selectedSortType: VacancyListSortType

    var body: some View {
        ListSectionTitleRow("Вакансии для вас")
            .padding(.bottom, 8)

        ListSortWithMenuRow<String>(
            "\(vacanciesCount) вакансий", // TODO: сделать поддержку числительных
            isLoading: isLoading,
            values: sortTypes.map {
                .init(
                    key: $0.rawValue,
                    title: $0.title,
                    image: .systemImage($0.imageSystemName)
                )
            },
            selectedValue: Binding(
                get: {
                    selectedSortType.rawValue
                }, set: { newValue in
                    guard let newValue,
                          let sortType = sortTypes.first(where: { $0.rawValue == newValue }) else {
                        return
                    }

                    selectedSortType = sortType
                }
            )
        )
        .padding(.vertical, 2)
    }
}

// MARK: -

struct BottomPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ShowBottomItemPreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

// MARK: - Preview

struct SearchVacancyScreen_Previews: PreviewProvider {
    struct Container: View {
        @StateObject private var diContainer = AppDIContainer()

        var body: some View {
            MainTabView()
                .environmentObject(diContainer)
        }
    }

    static var previews: some View {
        Container()
    }
}
