import SwiftUI

struct RectangleBlueFillableButtonStyle: ButtonStyle {
    var isFilled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.SFProDisplay.regular.suiFont(size: 14))
            .foregroundStyle(
                isFilled
                ? AppColor.Text.main.suiColor
                : AppColor.Text.accentBlue.suiColor
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Group {
                    if isFilled {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(AppColor.Button.blue.suiColor)
                            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
                    } else {
                        Color.clear
                    }
                }.animation(.easeInOut(duration: 0.2), value: isFilled)
            )
            .contentShape(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
            )
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
