import SwiftUI

struct FindWorkLoginView: View {

    @State private var userEmailOrPhone: String = ""

    @FocusState private var userEmailOrPhoneIsFocused: Bool
    @State private var isActive: Bool = false

    var onLoginAsWorkerTap: ((String) -> Void)?

    var body: some View {
        ZStack {
            VStack {
                Text(L10n.LoginScreen.searchWork)
                    .font(AppFont.SFProDisplay.medium.suiFont(size: 16))
                    .foregroundStyle(
                        isActive
                        ? AppColor.Text.main.suiColor
                        : AppColor.Text.accentBlue.suiColor
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer().frame(height: 13)

                HStack(spacing: 0) {
                    Image(systemName: "envelope")
                        .font(.system(size: 18, weight: .light))
                        .foregroundStyle(
                            isActive
                            ? AppColor.Text.main.suiColor
                            : AppColor.Text.accentBlue.suiColor
                        )
                        .frame(maxWidth: isActive ? 0 : .infinity)
                        .fixedSize()
                        .opacity(isActive ? 0 : 1)

                    TextField(
                        text: $userEmailOrPhone,
                        prompt: nil
                    ) {
                        Text(L10n.LoginScreen.emailOrPhone)
                            .foregroundStyle(
                                isActive
                                ? AppColor.grey4.suiColor
                                : AppColor.Text.accentBlue.suiColor
                            )
                    }
                    .focused($userEmailOrPhoneIsFocused)
                    .onChange(of: userEmailOrPhoneIsFocused) { newValue in
                        self.isActive = newValue
                    }
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.continue)
                    .font(AppFont.SFProDisplay.regular.suiFont(size: 14))
                    .foregroundStyle(AppColor.Text.main.suiColor)
                    .padding(EdgeInsets(top: 9, leading: 8, bottom: 9, trailing: 50))
                    .background(
                        Group {
                            if isActive {
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(AppColor.TextField.bgDarkGrey.suiColor)
                                    .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                            } else {
                                Color.clear
                            }
                        }.animation(.easeInOut, value: isActive)

                    )
                }.animation(.easeInOut, value: isActive)

                Spacer().frame(height: 16)

                HStack(spacing: 26) {
                    Button(L10n.Common.continue) {
                        // провести UI-валидацию, обновить вьюху, если невалидно
                        guard !userEmailOrPhone.isEmpty else {
                            print("Не введен emain / phone")
                            return
                        }
                        onLoginAsWorkerTap?(userEmailOrPhone)
                    }
                    .buttonStyle(RectangleBlueFillableButtonStyle(isFilled: isActive))

                    Button {
                        print("Нажата кнопка \"Войти с паролем\"")
                    } label: {
                        Text(L10n.LoginScreen.loginWithPassword)
                            .font(AppFont.SFProDisplay.regular.suiFont(size: 14))
                            .foregroundStyle(AppColor.Text.accentBlue.suiColor)
                            .shadow(color: .black.opacity(0.75), radius: 4, x: 0, y: 4)
                            .frame(maxHeight: .infinity)
                    }

                }
                .frame(maxWidth: .infinity, minHeight: 35, maxHeight: 35)
            }

        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 21, leading: 16, bottom: 23, trailing: 16))
        .background(
            Group {
                if isActive {
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(AppColor.bgSecondary.suiColor)
                        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                } else {
                    Color.clear
                }
            }.animation(.easeInOut(duration: 0.1), value: isActive)
        )
    }

}

#Preview {
    VStack {
        FindWorkLoginView()
    }
    .background(.black)
    .frame(width: .infinity, height: 500)
}
