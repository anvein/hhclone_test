import SwiftUI

struct TestFunctionalAlertModifier: ViewModifier {
    @Binding var textAlert: AlertMessage?
    var title: String = "Функционал в разработке"

    func body(content: Content) -> some View {
        content
            .alert(item: $textAlert) { item in
                Alert(
                    title: Text(title),
                    message: Text(item.text),
                    dismissButton: .default(Text("OK")) {
                        textAlert = nil
                    }
                )
            }
    }
}

extension View {
    func testFunctionalAlert(text: Binding<AlertMessage?>) -> some View {
        self.modifier(
            TestFunctionalAlertModifier(textAlert: text)
        )
    }

    func testFunctionalAlert(text: Binding<AlertMessage?>, title: String) -> some View {
        self.modifier(
            TestFunctionalAlertModifier(textAlert: text, title: title)
        )
    }
}

struct AlertMessage: Identifiable {
    let id = UUID()
    let text: String
}
