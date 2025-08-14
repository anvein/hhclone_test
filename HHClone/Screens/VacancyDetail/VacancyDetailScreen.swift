import SwiftUI

// MARK: - Main View

struct VacancyDetailScreen: View {
    @ObservedObject var viewModel: VacancyDetailViewModel

    init(viewModel: VacancyDetailViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            ContentContainerView {
                HeaderView(viewData: viewModel.viewData)

                StatisticView(
                    responsesCount: viewModel.viewData?.responsesCount ?? 0,
                    visitorsNow: viewModel.viewData?.visitorsNow ?? 0
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

                DescriptionView(viewModel.viewData?.descriptionMarkdownContent ?? "")

                RespondWithQuestionView { selectedQuestion in
                    viewModel.responseCoverLetter = selectedQuestion.messageText
                    viewModel.isShowResponseSheet = true
                }
            }

            RespondButtonView {
                viewModel.isShowResponseSheet = true
            }

            // TODO: УДАЛИТЬ!!! КОД ДЛЯ РАЗРАБОТКИ!!!
//            PixelPerfectScreenSui(imageName: "PIXEL_PERFECT_vacancy_detail")
        }
        .background(.bgMain)
        .sheet(isPresented: Binding(
            get: { viewModel.isShowResponseSheet },
            set: { viewModel.isShowResponseSheet = $0 }
        )) {
            VacancyResponseSheet(
                coverLetterText: viewModel.responseCoverLetter ?? "",
                contentHeight: Binding(
                    get: { viewModel.responseSheetHeight },
                    set: { viewModel.responseSheetHeight = $0 }
                )
            )
            .presentationDetents([.height(viewModel.responseSheetHeight)])
        }
        .onChange(of: viewModel.isShowResponseSheet) {
            viewModel.resetResponseSheetIfNeeded()
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
    let viewData: VacancyDetailViewData?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewData?.title ?? "...")
                .font(TextStyle.title22)

            Group {
                Text(viewData?.salary ?? "...")

                VStack(alignment: .leading, spacing: 6) {
                    if let experience = viewData?.experience {
                        Text("Требуемый опыт: \(experience)")
                    }

                    Text(viewData?.attributes ?? "...")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(TextStyle.text14)
        }
        .foregroundStyle(AppColor.Text.main.suiColor)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

fileprivate struct StatisticView: View {
    let responsesCount: Int
    let visitorsNow: Int

    var body: some View {
        HStack {
            VacancyActualStatView(
                text: "\(responsesCount) человек уже откликнулись",
                image: .Icons.statisticPerson
            )

            VacancyActualStatView(
                text: "\(visitorsNow) человека сейчас смотрят",
                image: .Icons.statisticEye
            )
        }
        .padding(.top, 27)
    }

}

fileprivate struct DescriptionView: View {
    let markdownContent: String

    init(_ markdownContent: String) {
        self.markdownContent = markdownContent
    }

    var body: some View {
        Text(LocalizedStringKey(markdownContent))
            .foregroundStyle(Color.Text.main)
            .font(TextStyle.text14)
            .lineSpacing(0.3)
            .padding(.top, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

}

fileprivate struct RespondWithQuestionView: View {
    let onTapQuestion: (VacancyResponseTemplate) -> Void

    var body: some View {
        VStack(spacing: 8) {
            Group {
                Text("Задайте вопрос работодателю")
                    .font(TextStyle.title14)
                    .foregroundStyle(Color.Text.main)

                Text("Он получит его с откликом на вакансию")
                    .font(TextStyle.text14)
                    .foregroundStyle(Color.Text.second)
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
        }
        .padding(.top, 27)
    }

}

fileprivate struct RespondButtonView: View {
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
                .safeAreaPadding(16)
            }
            .background(.bgMain)
        }
    }
}

// MARK: - Preview

struct VacancyDetailScreen_Previews: PreviewProvider {

    struct Container: View {
        @State private var path = [String]()

        var body: some View {
            TabView {
                NavigationStack(path: $path) {
                    EmptyView()
                        .navigationDestination(for: String.self) { view in
                            VacancyDetailScreen(
                                viewModel: .init(vacancy: .testVacancy)
                            )
                        }
                        .onAppear {
                            path.append("")
                        }
                }
                .tabItem {
                    Image(uiImage: AppImage.Icons.search.image)
                    Text("Поиск")
                }
                .background(.black)
                .tag(0)
            }
        }
    }

    static var previews: some View {
        Container()
    }

}
