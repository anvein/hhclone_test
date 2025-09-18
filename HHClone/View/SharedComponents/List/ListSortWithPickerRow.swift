import SwiftUI

struct ListSortWithPickerRow<T: Hashable>: View {
    typealias Value = (key: T, value: String)

    private let text: String?
    private var values: [Value]
    @State private var selectedValue: T?

    var body: some View {
        HStack {
            if let text {
                Text(text)
                    .font(TextStyle.text14)
                    .foregroundStyle(Color.Text.main)
                    .layoutPriority(-1)

                Spacer()

                Picker(selection: $selectedValue) {
                    ForEach(Array(values), id: \.key) { item in
                        Text(item.value)
                            .foregroundStyle(Color.Text.main)
                            .tag(item.key)

                    }
                } label: {
                }
                .pickerStyle(.menu)
                .font(TextStyle.title22)
                .tint(Color.Text.accentBlue)
            }

        }
        .frame(maxWidth: .infinity)
    }

    init(_ text: String?, values: [(Value)]) {
        self.text = text
        self.values = values
        self._selectedValue = State(initialValue: values.first?.key)
    }

}

#Preview {
    Group {
        ListSortWithPickerRow<String>(
            "145 вакансий",
            values: VacancyListSortType.allCases.map({ ($0.rawValue, $0.title) })
        )
    }
    .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
    .background(Color.bgMain)
}
