import SwiftUI

// MARK: - Main view

struct VacancyResponseSheet: View {

    static let defaultHeight: CGFloat = 200

    @ObservedObject private var viewModel: VacancyResponseViewModel
    @Binding var contentHeight: CGFloat

    @Environment(\.dismiss) var dismiss

    init(viewModel: VacancyResponseViewModel, contentHeight: Binding<CGFloat>) {
        self.viewModel = viewModel
        self._contentHeight = contentHeight
    }

    var body: some View {
        VStack {
            ResponseHeaderView(title: viewModel.vacancyTitle)

            ResponseCoverLetterView(
                isAddingCoverLetter: $viewModel.isAddingCoverLetter,
                coverLetterText: $viewModel.coverLetterText
            )

            ResponseButtonView(isLoading: viewModel.isLoading) {
                viewModel.sendResponse()
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(.horizontal, 16)
        .padding(.top, 24 + 10)
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(8)
        .presentationBackground(.bgMain)
        .interactiveDismissDisabled(viewModel.isLoading)
        .disabled(viewModel.isLoading)
        .getContentSize(height: $contentHeight)
        .onReceive(viewModel.$shouldClose) { isShouldClose in
            guard isShouldClose else { return }
            dismiss()
        }
    }

}

// MARK: - Subviews

fileprivate struct ResponseHeaderView: View {

    let title: String

    var body: some View {
        HStack(spacing: 16) {
            Image(.Icons.userAvatarGirlDummy)
                .frame(size: 48)

            VStack(alignment: .leading, spacing: 8) {
                Text("Резюме для отклика")
                    .font(TextStyle.text14)
                    .foregroundStyle(Color.grey3)

                Text(title)
                    .font(TextStyle.title16)
                    .foregroundStyle(Color.Text.main)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
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
    var isLoading: Bool
    var onTapButton: (() -> Void)?

    var body: some View {
        Button {
            onTapButton?()
        } label: {
            if isLoading {
                ProgressView()
            } else {
                Text("Откликнуться")
            }
        }
        .buttonStyle(FillRectangleButtonStyle(
            bgColor: .Button.green
        ))
        .frame(maxWidth: .infinity)
        .padding(.bottom, 22)
        .disabled(isLoading)
    }
}

// MARK: - View Extension shortcut

extension View {
    func vacancyResponseSheet(
        viewModel: Binding<VacancyResponseViewModel?>,
        height: Binding<CGFloat>
    ) -> some View {
        self.sheet(item: viewModel) { sheetVM in
            VacancyResponseSheet(
                viewModel: sheetVM,
                contentHeight: height
            )
            .presentationDetents([.height(height.wrappedValue)])
        }
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
                VacancyResponseSheet(
                    viewModel: .init(
                        vacancyId: Vacancy.testVacancy.id,
                        title: Vacancy.testVacancy.title
                    ),
                    contentHeight: $responseSheetHeight
                )
                .presentationDetents([.height(responseSheetHeight)])
            }
        }
    }

    static var previews: some View {
        Container()
    }

}
