import SwiftUI

// MARK: - Main view

struct HorizontalActionsView<Item: HorizontalActionItem>: View {
    let items: [Item]
    var itemSize: CGSize = .init(width: 132, height: 120)
    var spacing: CGFloat = 8
    var onTap: ((Item) -> Void)? = nil

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: spacing) {
                ForEach(items) { item in
                    HorizontalActionItemView(item: item, size: itemSize) { item in
                        onTap?(item)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.hidden, axes: [.horizontal])
        .frame(maxWidth: .infinity, minHeight: itemSize.height, maxHeight: itemSize.height)
    }

}

// MARK: - Subviews

fileprivate struct HorizontalActionItemView<Item: HorizontalActionItem>: View {
    let item: Item
    let size: CGSize
    let onTap: ((Item) -> Void)?

    @State private var isPressed: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(asset: item.icon.asset)
                .padding(.all, 4)
                .background(
                    Circle()
                        .fill(item.icon.bgColor)
                )

            Text(item.title)
                .padding(.top, 16)
                .font(TextStyle.title14)
                .foregroundStyle(AppColor.Text.main.suiColor)
                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 4)

            if let actionTitle = item.actionTitle {
                Text(actionTitle)
                    .foregroundStyle(item.icon.color)
                    .font(TextStyle.text14)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 10)
        .frame(width: size.width, height: size.height, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(AppColor.bgSecondary.suiColor)
        )
        .padding(.vertical, 20)
        .scaleEffect(isPressed ? 0.96 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .onTapGesture {
            onTap?(item)
        }
        .onLongPressGesture(
            minimumDuration: 0,
            maximumDistance: 100,
            perform: {},
            onPressingChanged: { isPressing in
                isPressed = isPressing
            }
        )
    }
}

// MARK: - Data structures

protocol HorizontalActionItem: Equatable, Identifiable where ID: Hashable {
    var icon: HorizontalActionIcon { get }
    var title: String { get }
    var actionTitle: String? { get }
}

struct HorizontalActionIcon {
    let asset: ImageAsset
    let color: Color
    let bgColor: Color
}

// MARK: - Preview

#Preview {
    HorizontalActionsView(items: SearchVacancyScreenAction.allCases)
        .padding(.vertical, 100)
        .background(.black)
}


