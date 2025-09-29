import SwiftUI
import Shimmer

// MARK: - Main View

struct VacancyDetailScreen: View {
    @ObservedObject var viewModel: VacancyDetailViewModel

    var body: some View {
        ZStack {
            ContentContainerView {
                HeaderView(viewData: viewModel.viewData, isLoading: viewModel.isLoading)

                StatisticView(
                    responsesCount: viewModel.viewData?.responsesCount ?? 0,
                    visitorsNow: viewModel.viewData?.visitorsNow ?? 0,
                    isLoading: viewModel.isLoading
                )

                if let viewData = viewModel.viewData {
                    VacancyEmployerLocationMapView(
                        title: viewData.employerTitle,
                        isVerify: viewData.isEmployerVerify,
                        address: viewData.address,
                        point: .init(latitude: 57.139684, longitude: 65.593876)
                    )
                    .padding(.top, 19)
                }

                DescriptionView(
                    viewModel.viewData?.descriptionMarkdownContent ?? "",
                    isLoading: viewModel.isLoading
                )

                RespondWithQuestionView(isLoading: viewModel.isLoading) { selectedQuestion in
                    viewModel.showResponseSheet(coverLetterText: selectedQuestion.messageText)
                }
            }

            RespondButtonView(isLoading: viewModel.isLoading) {
                viewModel.showResponseSheet()
            }

#if DEBUG
            // TODO: УДАЛИТЬ!!! КОД ДЛЯ РАЗРАБОТКИ!!!
            PixelPerfectScreenSui(imageName: "PIXEL_PERFECT_vacancy_detail")
#endif
        }
        .background(.bgMain)
        .toolbar {
            NavigationBarToolbar(viewModel: viewModel)
        }
        .vacancyResponseSheet(
            viewModel: $viewModel.responseSheetViewModel,
            height: $viewModel.responseSheetHeight
        )
        .testFunctionalAlert(text: $viewModel.alertText)
        .onAppear {
            viewModel.loadVacancy()
        }
    }

}

// MARK: - Components

fileprivate struct ContentContainerView<Content: View>: View {
    private let content: () -> Content

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                content()
            }
            .padding(.top, 8)
            .padding(.bottom, 16 + 48 + 50)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
        }
    }

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }
}

fileprivate struct HeaderView: View {
    @State private var width: CGFloat = .zero

    let viewData: VacancyDetailViewData?
    let isLoading: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewData?.title ?? "")
                .font(TextStyle.title22)
                .skeleton(isLoading: isLoading, width: width * 0.75, height: 22)
                .shimmeringWhiteSoft(active: isLoading)

            Group {
                if let viewData {
                    Text(viewData.salary ?? "Уровень дохода не указан")
                        .font(viewData.salary != nil ? TextStyle.title16 : TextStyle.text14)
                        .skeleton(isLoading: isLoading, width: width * 0.55, height: 20)
                        .shimmeringWhiteSoft(active: isLoading)

                } else {
                    Text("")
                        .skeleton(isLoading: isLoading, width: width * 0.55, height: 20)
                        .shimmeringWhiteSoft(active: isLoading)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Требуемый опыт: \(viewData?.experience ?? "")")
                        .skeleton(isLoading: isLoading, width: width * 0.4, height: 16)
                        .shimmeringWhiteSoft(active: isLoading)

                    Text(viewData?.attributes ?? "")
                        .skeleton(isLoading: isLoading, width: width * 0.4, height: 16)
                        .shimmeringWhiteSoft(active: isLoading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(TextStyle.text14)
        }
        .foregroundStyle(AppColor.Text.main.suiColor)
        .frame(maxWidth: .infinity, alignment: .leading)
        .getContentSize(width: $width)
    }
}

fileprivate struct StatisticView: View {
    let responsesCount: Int
    let visitorsNow: Int
    let isLoading: Bool

    var body: some View {
        HStack {
            VacancyActualStatView(
                text: "\(responsesCount) человек уже откликнулись",
                image: .Icons.statisticPerson
            )
            .skeleton(isLoading: isLoading, color: .Shimmer.textGreen1, height: 50)
            .shimmeringWhiteSoft(active: isLoading)

            VacancyActualStatView(
                text: "\(visitorsNow) человека сейчас смотрят",
                image: .Icons.statisticEye
            )
            .skeleton(isLoading: isLoading, color: .Shimmer.textGreen1, height: 50)
            .shimmeringWhiteSoft(active: isLoading)
        }
        .padding(.top, 27)
    }

}

fileprivate struct DescriptionView: View {
    let markdownContent: String
    let isLoading: Bool

    init(_ markdownContent: String, isLoading: Bool) {
        self.markdownContent = markdownContent
        self.isLoading = isLoading
    }

    var body: some View {
        Text(LocalizedStringKey(markdownContent))
            .foregroundStyle(Color.Text.main)
            .font(TextStyle.text14)
            .lineSpacing(0.3)
            .skeleton(isLoading: isLoading, height: 90)
            .shimmeringWhiteSoft(active: isLoading)
            .padding(.top, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

}

fileprivate struct RespondWithQuestionView: View {
    let isLoading: Bool
    let onTapQuestion: (VacancyResponseTemplate) -> Void

    @State var width: CGFloat = .zero

    var body: some View {
        VStack(spacing: 8) {
            Group {
                Text("Задайте вопрос работодателю")
                    .font(TextStyle.title14)
                    .foregroundStyle(Color.Text.main)
                    .skeleton(isLoading: isLoading, width: width * 0.85, height: 20)
                    .shimmeringWhiteSoft(active: isLoading)

                Text("Он получит его с откликом на вакансию")
                    .font(TextStyle.text14)
                    .foregroundStyle(Color.Text.second)
                    .skeleton(isLoading: isLoading, width: width * 0.6, height: 18)
                    .shimmeringWhiteSoft(active: isLoading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer().frame(height: 8)

            VacancyResponseQuestionsLayout {
                ForEach(VacancyResponseTemplate.allCases, id: \.text) { item in
                    Button(item.text) {
                        onTapQuestion(item)
                    }
                    .buttonStyle(VacancyResponseQuestionButtonStyle())
                }
            }
            .frame(maxWidth: .infinity)
            .skeleton(isLoading: isLoading, height: 60)
            .shimmeringWhiteSoft(active: isLoading)
        }
        .getContentSize(width: $width)
        .padding(.top, 27)
    }

}

fileprivate struct RespondButtonView: View {
    let isLoading: Bool
    let onTapButton: () -> Void

    var body: some View {
        VStack {
            Spacer()

            HStack {
                Button("Откликнуться") {
                    onTapButton()
                }
                .buttonStyle(FillRectangleButtonStyle(
                    bgColor: .Button.green
                ))
                .frame(maxWidth: .infinity)
                .skeleton(
                    isLoading: isLoading,
                    color: .Shimmer.textGreen1,
                    height: FillRectangleButtonStyle.defaultHeight
                )
                .shimmeringWhiteSoft(active: isLoading)
                .safeAreaPadding(16)
            }
            .background(.bgMain)
        }
    }
}

fileprivate struct NavigationBarToolbar: ToolbarContent {
    @ObservedObject var viewModel: VacancyDetailViewModel

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {
                viewModel.alertText = .init(
                    text: "Обновить поле isHidden у вакансии + сделать глаз закрытым"
                )
            } label: {
                Image(.Icons.eye)
                .resizable()
                .tint(AppColor.grey4.suiColor)
                .disabled(viewModel.isLoading)
                .frame(size: 28)
            }
            
            Button {
                viewModel.alertText = .init(text: "Показать экран шэринга вакансии")
            } label: {
                Image(.Icons.share)
                .resizable()
                .tint(AppColor.grey4.suiColor)
                .disabled(viewModel.isLoading)
                .frame(size: 24)
            }

            let favouriteSize: CGFloat = 26
            let isFavourite = viewModel.viewData?.isFavourite ?? false
            Button {
                viewModel.toggleIsFavourite()
            } label: {
                Image(isFavourite ? .Icons.heartFill : .Icons.heart)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundStyle(isFavourite ? Color.Button.blue : .white)
                    .frame(size: favouriteSize)
                    .id(isFavourite)
            }
            .skeleton(isLoading: viewModel.isLoading, width: favouriteSize, height: favouriteSize)
            .shimmeringWhiteSoft(active: viewModel.isLoading)
        }
    }
}


// MARK: - Preview

struct VacancyDetailScreen_Preview: PreviewProvider {

    struct Container: View {
        @StateObject private var diContainer = AppDIContainer()

        var body: some View {
            TabView {
                NavigationStack {
                    VacancyDetailScreen(
                        viewModel: .init(
                            vacancyService: diContainer.vacancyService,
                            vacancyId: Vacancy.testVacancy.id
                        )
                    )
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {}) {
                                Image(systemName: "chevron.left")
                                Text("Назад")
                            }
                            .tint(.white)
                        }
                    }
                    .toolbarBackground(.black, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarBackground(.black, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
                }
                .background(.black)
            }
        }
    }

    static var previews: some View {
        Container()
    }

}
