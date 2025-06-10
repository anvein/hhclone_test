import SwiftUI

struct LoginCodeScreen: View {
    static let screenId: String = String(describing: Self.self)

    private let model: LoginCodeScreenModel

    private let codeLenght: Int = 4

    @Binding private var path: [Route]
    @State private var isInvalidCode: Bool = false
    @State private var isFilledCode: Bool = false
    @State private var enteredCode: String?

    @AppStorage(DefaultsKeys.isLoggedIn.rawValue) var isLoggedIn: Bool = false

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            Text("Отправили код на \(model.value)")
                .font(AppFont.SFProDisplay.semibold.suiFont(size: 20))
                .foregroundStyle(AppColor.Text.main.suiColor)
                .frame(maxWidth: .infinity)

            Spacer().frame(height: 16)

            Text("Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет")
                .frame(maxWidth: .infinity)
                .font(AppFont.SFProDisplay.medium.suiFont(size: 16))
                .foregroundStyle(AppColor.Text.main.suiColor)
                .multilineTextAlignment(.center)

            Spacer().frame(height: 20)

            LoginCodeField(codeLength: codeLenght, enteredCode: $enteredCode)
                .frame(maxWidth: .infinity)

            if isInvalidCode {
                Text("Неверный код. Попробуйте еще раз")
                    .frame(maxWidth: .infinity)
                    .font(AppFont.SFProDisplay.regular.suiFont(size: 16))
                    .padding(.top, 10)
                    .foregroundStyle(AppColor.Text.redError.suiColor)
                    .multilineTextAlignment(.center)
            }

            Spacer().frame(height: 20)

            Button(action: {
                checkCode()
            }) {
                Text("Подтвердить")
                    .font(AppFont.SFProDisplay.regular.suiFont(size: 16))
                    .foregroundStyle(AppColor.Text.main.suiColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(
                                isFilledCode ? AppColor.Button.blue.suiColor : AppColor.Button.disableGrey
                                    .suiColor
                            )
                    )
                    .animation(.easeInOut, value: isFilledCode)
            }
            .frame(maxHeight: 48)
            .disabled(!isFilledCode)

            HStack(alignment: .center) {
                Button {
                    path.removeLast()
                } label: {
                    Text("Отменить")
                        .font(AppFont.SFProDisplay.regular.suiFont(size: 16))
                        .padding(10)
                }
            }
            .frame(maxWidth: .infinity)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .background(AppColor.bgMain.suiColor)
        .navigationBarBackButtonHidden(true)
        .animation(.bouncy, value: isInvalidCode)
        .onChange(of: enteredCode) { oldValue, newValue in
            isFilledCode = newValue?.count == codeLenght ? true : false
            if oldValue != newValue {
                isInvalidCode = false
            }
        }
    }

    // MARK: - Init

    init(path:  Binding<[Route]>, model: LoginCodeScreenModel) {
        self.model = model
        self._path = path
    }

    // MARK: - Network

    private func checkCode() {
        DispatchQueue.global(qos: .userInteractive).async {
            // запросить метод проверки кода
            if enteredCode == "1111" {
                isInvalidCode = false
                isLoggedIn = true
                path.removeLast()
            } else {
                isInvalidCode = true
            }
        }
    }
}

// MARK: - ViewModel

struct LoginCodeScreenModel: Hashable {
    let loginType: LoginType

    var value: String {
        switch loginType {
        case .email(let email):
            return email
        case .phone(let phoneNumber):
            return phoneNumber
        }
    }

    static func == (lhs: LoginCodeScreenModel, rhs: LoginCodeScreenModel) -> Bool {
        lhs.loginType.hashValue == rhs.loginType.hashValue
    }
}

enum LoginType: Hashable {
    case email(String)
    case phone(String)
}

// MARK: - Preview

struct LoginCodeScreen_Previews: PreviewProvider {
    struct Container: View {
        @State var path: [Route] = []

        var body: some View {
            LoginCodeScreen(
                path: $path,
                model: .init(
                    loginType: .email("anvein@bk.ru")
                )
            )
        }
    }

    static var previews: some View {
        Container()
    }
}


