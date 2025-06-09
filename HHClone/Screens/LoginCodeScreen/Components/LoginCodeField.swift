import SwiftUI

struct LoginCodeField: View {

    let codeLength: Int

    @State var isFilledCode: Bool = false
    @State var isInvalidCode: Bool = false
    @State var textFieldsValues: [String] = []
    @FocusState private var focusedField: Int?
    @State var enteredCode: String?

    typealias BoolCallback = ((Bool) -> Void)
    typealias OptionalStringCallback = ((String?) -> Void)

    private var onChangeIsInvalidCode: BoolCallback?
    private var onChangeIsFilledCode: BoolCallback?
    private var onChangedEnteredCode: OptionalStringCallback?

    var body: some View {
        HStack {
            ForEach(textFieldsValues.indices, id: \.self) { index in
                TextField(text: $textFieldsValues[index]) {
                    Text("*")
                        .foregroundStyle(AppColor.Text.grey.suiColor)
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
                .onChange(of: textFieldsValues[index]) { newValue in
                    let filtered = newValue.filter { $0.isNumber }
                    let firstChar = filtered.first
                    if let firstChar {
                        textFieldsValues[index] = String(firstChar)

                        let nextIndex = index + 1
                        focusedField = textFieldsValues.indices.contains(nextIndex) ? nextIndex : nil
                    } else {
                        textFieldsValues[index] = ""
                    }
                    isInvalidCode = false

                    updateEnteredCodeState()
                    checkIsFilledCode()
                }
                .focused($focusedField, equals: index)
            }
        }
        .frame(height: 48)
        .onChange(of: isInvalidCode) { newValue in
            onChangeIsInvalidCode?(newValue)
        }

//        .onAppear {
//            if textFieldsValues.isEmpty {
//                textFieldsValues = .init(repeating: "", count: codeLength)
//            }
//        }
    }

    // MARK: -

    init(
        codeLength: Int,
        onChangeIsInvalidCode: BoolCallback? = nil,
        onChangeIsFilledCode: BoolCallback? = nil,
        onChangedEnteredCode: OptionalStringCallback? = nil
    ) {
        self.codeLength = codeLength
        self.onChangeIsInvalidCode = onChangeIsInvalidCode
        self.onChangeIsFilledCode = onChangeIsFilledCode
        self.onChangedEnteredCode = onChangedEnteredCode

        _textFieldsValues = State(
            initialValue: .init(repeating: "", count: codeLength)
        )
    }

    // MARK: -

    private func checkIsFilledCode() {
        let newValue = enteredCode?.count == codeLength
        if newValue != isFilledCode {
            onChangeIsFilledCode?(newValue)
        }

        isFilledCode = newValue
    }

    private func updateEnteredCodeState() {
        let code = textFieldsValues.joined()
        enteredCode = !code.isEmpty ? code : nil
        onChangedEnteredCode?(enteredCode)
    }

}



#Preview {
    LoginCodeField(
        codeLength: 4,
        onChangeIsInvalidCode: nil,
        onChangeIsFilledCode: nil,
        onChangedEnteredCode: nil
    )
        .background(AppColor.bgMain.suiColor)
}
