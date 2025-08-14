import SwiftUI

struct ListSectionTitleRow: View {

    private var text: String

    var body: some View {
        Text(text)
            .font(TextStyle.title20)
            .foregroundStyle(AppColor.Text.main.suiColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize()
    }

    init(_ text: String) {
        self.text = text
    }

}
