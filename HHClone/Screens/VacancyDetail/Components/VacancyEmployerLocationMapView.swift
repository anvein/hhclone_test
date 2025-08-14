import SwiftUI

struct VacancyEmployerLocationMapView: View {

    var title: String
    var isVerify: Bool
    var address: String
    var point: MapPoint

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

            RoundedRectangle(cornerRadius: 8)
                .fill(Color.grey3)
                .frame(maxWidth: .infinity, idealHeight: 58)

            Text(address)
                .font(TextStyle.text14)
                .foregroundStyle(Color.Text.main)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.bgSecondary)
        .clipShape(
            RoundedRectangle(cornerRadius: 8)
        )
    }

}

#Preview {
    VStack {
        VacancyEmployerLocationMapView(
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
