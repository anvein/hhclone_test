import SwiftUI

struct LoginCodeField: View {

    let codeLength: Int

    @State var textFieldsValues: [String] = []
    @Binding var enteredCode: String?
    @FocusState private var focusedField: Int?

    typealias OptionalStringCallback = ((String?) -> Void)

    private var onChangedEnteredCode: OptionalStringCallback?

    var body: some View {
        HStack {
            ForEach(textFieldsValues.indices, id: \.self) { index in
                TextField(text: $textFieldsValues[index]) {
                    Text("*")
                        .foregroundStyle(AppColor.grey4.suiColor)
                        .font(AppFont.SFProDisplay.medium.suiFont(size: 24))
                }
                .multilineTextAlignment(.center)
                .font(AppFont.SFProDisplay.medium.suiFont(size: 24))
                .foregroundStyle(AppColor.Text.main.suiColor)
                .keyboardType(.numberPad)
                .tint(AppColor.Text.main.suiColor)
                .frame(maxWidth: 48, maxHeight: .infinity)
                .background(AppColor.TextField.bgDarkGrey.suiColor)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onChange(of: textFieldsValues[index], { oldValue, newValue in
                    handleChangeTextInTextField(with: index, oldValue: oldValue, newValue: newValue)
                })
                .focused($focusedField, equals: index)
            }
        }
        .frame(height: 48)
    }

    // MARK: -

    init(
        codeLength: Int,
        enteredCode: Binding<String?>
    ) {
        self.codeLength = codeLength
        self._enteredCode = enteredCode

        _textFieldsValues = State(
            initialValue: .init(repeating: "", count: codeLength)
        )
    }

    // MARK: -

    private func handleChangeTextInTextField(with index: Int, oldValue: String, newValue: String) {
        // TODO: переделать на делегат UITextField
        // backspace в пустом поле не работает
        // переходит к предыдущему полю если ввести не цифру

        defer {
            updateEnteredCode()
        }

        guard newValue.count <= 1 else {
            textFieldsValues[index] = oldValue
            return
        }

        if !oldValue.isEmpty && newValue.isEmpty {
            let prevIndex = index - 1
            focusedField = textFieldsValues.indices.contains(prevIndex) ? prevIndex : focusedField
            return
        }

        let filtered = newValue.filter { $0.isNumber }
        let firstChar = filtered.first
        if let firstChar {
            textFieldsValues[index] = String(firstChar)

            let nextIndex = index + 1
            focusedField = textFieldsValues.indices.contains(nextIndex) ? nextIndex : nil
        } else {
            textFieldsValues[index] = ""
        }
    }

    private func updateEnteredCode() {
        let code = textFieldsValues.joined()
        enteredCode = !code.isEmpty ? code : nil
    }

}


// MARK: - Preview

struct LoginCodeField_Previews: PreviewProvider {
    struct Container: View {
        @State var enteredCode: String?

        var body: some View {
            LoginCodeField(
                codeLength: 4,
                enteredCode: $enteredCode
            )
        }
    }

    static var previews: some View {
        Container()
            .background(AppColor.bgMain.suiColor)
    }
}
