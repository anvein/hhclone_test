import SwiftUI

struct RectangleBlueButtonStyle: ButtonStyle {
    var isDisabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.SFProDisplay.regular.suiFont(size: 16))
            .foregroundStyle(AppColor.Text.main.suiColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(
                        isDisabled ? AppColor.Button.disableGrey.suiColor : AppColor.Button.blue.suiColor
                    )
            )
            .animation(.easeInOut, value: isDisabled)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
