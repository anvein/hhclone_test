import SwiftUI

// MARK: - View Model

final class VacancyResponseViewModel: ObservableObject {
//    @Published var vacancyTitle: String
//
//    init(vacancy: Vacancy) {
//        fillData(from: vacancy)
//    }
//
//    // MARK: -
//
//    private func fillData(from vacancy: Vacancy) {
//        vacancyTitle = vacancy.title
//    }
}



// MARK: - Main view

struct VacancyResponseSheet: View {

    static let defaultHeight: CGFloat = 200

//    @StateObject private var viewModel: VacancyResponseViewModel

    @State private var isAddingCoverLetter: Bool = false
    @State private var coverLetterText: String = ""

    @Binding var contentHeight: CGFloat

    init(
        coverLetterText: String = "",
        contentHeight: Binding<CGFloat>
    ) {
        self._coverLetterText = State(initialValue: coverLetterText)
        self._contentHeight = contentHeight
    }

    var body: some View {
        VStack {
            ResponseHeaderView()

            ResponseCoverLetterView(
                isAddingCoverLetter: $isAddingCoverLetter,
                coverLetterText: $coverLetterText
            )

            ResponseButtonView {
                print("Отправить отклик на вакансию \(Int.random(in: 0...10))")
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(.horizontal, 16)
        .padding(.top, 24 + 10)
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(8)
        .presentationBackground(.bgMain)
        .getContentSize(height: $contentHeight)
    }

}

// MARK: - Components

fileprivate struct ResponseHeaderView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image(.Icons.userAvatarGirlDummy)
                .frame(size: 48)

            VStack(alignment: .leading, spacing: 8) {
                Text("Резюме для отклика")
                    .font(TextStyle.text14)
                    .foregroundStyle(Color.grey3)

                Text("UI/UX дизайнер")
                    .font(TextStyle.title16)
                    .foregroundStyle(Color.Text.main)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }

        Divider()
            .frame(height: 1)
            .background(.grey2)
            .padding(.top, 14)
    }
}

fileprivate struct ResponseCoverLetterView: View {
    @Binding var isAddingCoverLetter: Bool
    @Binding var coverLetterText: String

    @State private var isEditingCoverLetter: Bool = false

    var body: some View {
        if isAddingCoverLetter || !coverLetterText.isEmpty {
            Spacer().frame(height: 16)

            CoverLetterTextEditor(
                text: $coverLetterText,
                isFocused: $isEditingCoverLetter,
                placeholder: "Ваше сопроводительное письмо"
            )

            Spacer().frame(height: 11)
        } else {
            Spacer().frame(height: 26)

            Button {
                withAnimation {
                    isAddingCoverLetter = true
                }
                isEditingCoverLetter = true
            } label: {
                Text("Добавить сопроводительное")
                    .padding(14)
            }
            .buttonStyle(
                AppPlainButtonStyle(
                    textColor: .Button.green,
                    fontWeight: .semibold
                )
            )
        }
    }
}

fileprivate struct CoverLetterTextEditor: View {
    @Binding var text: String
    @Binding var isFocused: Bool
    let placeholder: String

    @FocusState private var internalIsFocused: Bool

    var body: some View {
        TextEditor(text: $text)
            .frame(height: 85)
            .scrollContentBackground(.hidden)
            .background(.bgMain)
            .tint(.Text.main)
            .foregroundStyle(Color.Text.main)
            .font(TextStyle.text14)
            .autocorrectionDisabled(true)
            .focused($internalIsFocused, equals: true)
            .overlay {
                if text == "" {
                    Text(placeholder)
                        .font(TextStyle.text14)
                        .foregroundStyle(.grey3)
                        .disabled(true)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .topLeading
                        )
                        .padding(.leading, 5)
                        .padding(.top, 8)
                }
            }
            .onAppear {
                internalIsFocused = isFocused
            }
            .onChange(of: isFocused) { newValue in
                internalIsFocused = newValue
            }
            .onChange(of: internalIsFocused) { newValue in
                isFocused = newValue
            }
    }
}

fileprivate struct ResponseButtonView: View {
    var onTapButton: (() -> Void)?

    var body: some View {
        Button("Откликнуться") {
            onTapButton?()
        }
        .buttonStyle(FillRectangleButtonStyle(
            bgColor: .Button.green
        ))
        .frame(maxWidth: .infinity)
        .padding(.bottom, 22)
    }
}

// MARK: - Preview


struct VacancyResponseSheet_Preview: PreviewProvider {

    struct Container: View {
        @State private var isShowSheet: Bool = true
        @State private var responseSheetHeight: CGFloat = 0

        var body: some View {
            ZStack {
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .sheet(isPresented: $isShowSheet) {
                VacancyResponseSheet(contentHeight: $responseSheetHeight)
                    .presentationDetents([.height(responseSheetHeight)])
            }
        }
    }

    static var previews: some View {
        Container()
    }

}
