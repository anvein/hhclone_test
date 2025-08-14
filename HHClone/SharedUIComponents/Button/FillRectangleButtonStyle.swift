import SwiftUI

struct FillRectangleButtonStyle: ButtonStyle {
    var isDisabled: Bool = false
    var bgColor: Color = .Button.blue
    var disabledColor: Color = .Button.disableGrey
    var height: CGFloat = 46

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(AppFont.SFProDisplay.semibold.suiFont(size: 16))
            .foregroundStyle(Color.Text.main)
            .padding(13)
            .frame(maxWidth: .infinity, maxHeight: height)
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(isDisabled ? disabledColor : bgColor)
            )
            .animation(.easeInOut, value: isDisabled)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }
}
