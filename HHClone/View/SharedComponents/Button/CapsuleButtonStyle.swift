import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    var verticalPadding: CGFloat
    var textColor: Color = AppColor.Text.main.suiColor
    var fillColor: Color = AppColor.Button.green.suiColor
    var textWithShadow: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.SFProDisplay.regular.suiFont(size: 14))
            .foregroundStyle(textColor)
            .applyIf(textWithShadow) { label in
                label.shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 4)
            }
            .padding(.vertical, 7)
            .frame(maxWidth: .infinity)
            .background(
                Capsule(style: .circular)
                    .fill(fillColor)
            )
            .contentShape(
                Capsule(style: .circular)
            )
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
