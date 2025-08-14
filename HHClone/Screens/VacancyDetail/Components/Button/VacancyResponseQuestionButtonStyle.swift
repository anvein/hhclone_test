import SwiftUI

struct VacancyResponseQuestionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .lineLimit(1)
            .font(TextStyle.title14)
            .padding(.init(vertical: 8, horizontal: 12))
            .foregroundStyle(Color.Text.main)
            .background(Color.Button.grey)
            .clipShape(.capsule)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
    }
}

