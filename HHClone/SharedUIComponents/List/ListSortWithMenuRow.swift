import SwiftUI

struct ListSortWithMenuRow<T: Hashable>: View {
    private let text: String?
    private let values: [MenuItem<T>]
    @Binding private var selectedValueKey: T?

    // MARK: - View

    var body: some View {
        HStack {
            LeftTextView(text: text)

            Spacer()

            SortMenuView<T>(
                values: values,
                selectedValueKey: $selectedValueKey
            )
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Init

    init(_ text: String?, values: [MenuItem<T>], selectedValue: Binding<T?>) {
        self.text = text
        self.values = values
        self._selectedValueKey = selectedValue
    }

    // MARK: - Support

    enum ImageType {
        case imageAsset(ImageAsset)
        case systemImage(String)
    }

    struct MenuItem<Key: Hashable> {
        let key: Key
        let title: String
        let image: ImageType?
    }
}

// MARK: - Subviews

fileprivate struct LeftTextView: View {
    let text: String?

    var body: some View {
        if let text {
            Text(text)
                .font(TextStyle.text14)
                .foregroundStyle(Color.Text.main)
                .layoutPriority(-1)
        } else {
            EmptyView()
        }
    }

}

fileprivate struct SortMenuView<T: Hashable>: View {
    let values: [ListSortWithMenuRow<T>.MenuItem<T>]
    @Binding var selectedValueKey: T?

    var body: some View {
        Menu {
            ForEach(values, id: \.key) { item in
                Button {
                    selectedValueKey = item.key
                } label: {
                    HStack {
                        Text(item.title)

                        if let iconImage = item.image {
                            menuVariantImageView(for: iconImage)
                                .tint(.Text.mainReversed)
                        }
                    }
                }
            }
        } label: {
            Label {
                HStack(spacing: 6) {
                    Text(
                        values.first(where: {$0.key == selectedValueKey})?.title ?? ""
                    )
                    .font(TextStyle.text14)

                    AppImage.Icons.sortArrows.swiftUIImage
                        .renderingMode(.template)
                }
            } icon: {
                EmptyView()
            }
            .foregroundStyle(.blueAccent)
        }
    }

    @ViewBuilder
    private func menuVariantImageView(for image: ListSortWithMenuRow<T>.ImageType) -> some View {
        switch image {
        case .imageAsset(let asset):
            Image(asset: asset)
        case .systemImage(let imageName):
            Image(systemName: imageName)
        }
    }

}

// MARK: - Preview

#Preview {
    Group {
        ListSortWithMenuRow<String>(
            "145 вакансий",
            values: VacanciesListSortType.allCases
                .map({
                    .init(
                        key: $0.rawValue,
                        title: $0.title,
                        image: .systemImage($0.imageSystemName)
                    )
                }),
            selectedValue: .constant(nil)
        )
    }
    .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
    .background(Color.bgMain)
}
