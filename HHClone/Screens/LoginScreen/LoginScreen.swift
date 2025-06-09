import SwiftUI
import MapKit

struct LoginScreen: View {
    static let screenId: String = String(describing: Self.self)

    @State private var userEmailOrPhone: String = ""

    @FocusState private var userEmailOrPhoneIsFocused: Bool
    @State private var isActiveBlock: Bool = false

    @Binding var path: [Route]

    var body: some View {
        ZStack {
            AppColor.bgMain.suiColor
                .ignoresSafeArea()

            VStack {
                Text(L10n.LoginScreen.title)
                    .font(AppFont.SFProDisplay.semibold.suiFont(size: 20))
                    .foregroundStyle(AppColor.Text.main.suiColor)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.top, 18)
                    .padding(.leading, 3)

                Spacer()
                    .frame(maxHeight: 118)

                
                FindWorkLoginView { emailOrPhone in
                    // провалидировать
                    // определить email это или телефон
                    sendCode(loginType: .email(emailOrPhone))
                }

                Spacer().frame(height: 20)

                FindEmployeeLoginView()

                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)

//            Image("PIXEL_PERFECT_login")
//                .resizable()
//                .frame(alignment: .top)
//                .ignoresSafeArea(edges: .top)
        }

    }


    // MARK: - Methods

    private func sendCode(loginType: LoginType) {
        // показать лоадер

        switch loginType {
        case .email(let email):
            DispatchQueue.global(qos: .userInitiated).async {
                print("sended code to email \(email)")
                let model = LoginCodeScreenModel(loginType: loginType)

                DispatchQueue.main.async {
                    path.append(.loginCodeScreen(model))
                }

            }
        case .phone(let phoneNumber):
            DispatchQueue.global(qos: .userInitiated).async {
                print("sended code to phone \(phoneNumber)")
                // отправить код на телефон
            }
        }
    }
}

// MARK: - Preview

struct LoginScreen_Previews: PreviewProvider {
    struct Container: View {
        @State var path: [Route] = []

        var body: some View {
            LoginScreen(path: $path)
        }
    }

    static var previews: some View {
        Container()
    }

}

