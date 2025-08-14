import SwiftUI

struct FindEmployeeLoginView: View {
    var body: some View {
        VStack {
            Text(L10n.LoginScreen.SearchEmployees.title)
                .font(AppFont.SFProDisplay.medium.suiFont(size: 16))
                .foregroundStyle(AppColor.Text.main.suiColor)
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 4)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(L10n.LoginScreen.SearchEmployees.descr)
                .font(AppFont.SFProDisplay.regular.suiFont(size: 14))
                .foregroundStyle(AppColor.Text.main.suiColor)
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 4)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, -2)

            Button(L10n.LoginScreen.SearchEmployees.buttonText) {
                print("Нажата кнопка Я ищу сотрудников")
            }
            .buttonStyle(CapsuleButtonStyle(verticalPadding: 7, textWithShadow: true))
            .padding(.top, 8)
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 22)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(AppColor.bgSecondary.suiColor)
        )
    }

}
