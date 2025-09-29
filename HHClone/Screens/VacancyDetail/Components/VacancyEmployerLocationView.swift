import SwiftUI
import YandexMapsMobile

struct VacancyEmployerLocationView: View {

    var title: String
    var isVerify: Bool
    var address: String
    var point: YMKPoint?

    @State var width: CGFloat = .zero

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                Text(title)
                    .font(TextStyle.title16)
                    .foregroundStyle(Color.Text.main)

                Image(.Icons.employerVerify)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundStyle(.grey3)
                    .frame(width: 16, height: 16)
                    .padding(.top, 2)
            }

            if let point {
                YandexMapView(coordinate: point, isGestureEnabled: false)
                    .frame(maxWidth: .infinity, idealHeight: width * 0.21)
                    .clipRoundedRectangle(cornerRadius: 8)
            }

            Text(address)
                .font(TextStyle.text14)
                .foregroundStyle(Color.Text.main)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.bgSecondary)
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
        .getContentSize(width: $width)
    }

}

#Preview {
    VStack {
        VacancyEmployerLocationView(
            title: "Мобирикс",
            isVerify: true,
            address: "Минск, улица Бирюзова, 4/5",
            point: .init(latitude: 57.139684, longitude: 65.593876)
        )
        .frame(height: 134)
        .padding(.horizontal, 16)
    }
    .frame(maxHeight: .infinity)
    .background(.bgMain)

}
