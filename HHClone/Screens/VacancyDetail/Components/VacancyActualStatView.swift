import SwiftUI

struct VacancyActualStatView: View {
    var text: String
    var image: ImageResource

    var body: some View {
        HStack(spacing: 0) {
            Text(text)
                .lineLimit(2)
                .foregroundStyle(AppColor.Text.main.suiColor)
                .font(TextStyle.text14)

            Spacer()

            VStack() {
                ZStack {
                    Circle()
                        .fill(Color.green)
                        .frame(width: 16, height: 16)

                    Image(image)
                        .frame(maxWidth: 12, maxHeight: 8)
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 8)
        .background(AppColor.Icons.bgGreen.suiColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }

}

#Preview(body: {
    VStack {
        VacancyActualStatView(
            text: "147 человек уже откликнулись",
            image: .Icons.statisticPerson
        )
            .frame(width: 160, height: 50)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.black)
})
