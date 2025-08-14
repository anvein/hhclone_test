import SwiftUI

struct AppPlainButtonStyle: ButtonStyle {

    var textColor: Color = .Text.accentBlue
    var fontWeight: SupportFontWeight = .regular

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(fontWeight.font.suiFont(size: 16))
            .foregroundStyle(textColor)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
    }

    enum SupportFontWeight {
        case regular, semibold

        var font: FontConvertible {
            switch self {
            case .regular: AppFont.SFProDisplay.regular
            case .semibold: AppFont.SFProDisplay.semibold
            }
        }
    }
}
