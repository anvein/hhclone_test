import SwiftUI

struct VacancyListRowView: View {

    @State private var favoriteIsPressing: Bool = false
    @ObservedObject var vacancy: VacancyRowViewModel

    var onTapAddToFavourite: (() -> Void)? = nil
    var onTapApplyToVacancy: (() -> Void)? = nil

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(spacing: 10) {
                    Group {
                        Text(vacancy.viewersNowText)
                            .font(TextStyle.title14)
                            .foregroundStyle(AppColor.Text.green.suiColor)

                        Text(vacancy.title)
                            .font(TextStyle.title16)

                        if let salaryText = vacancy.salaryRangeText {
                            Text("\(salaryText)")
                                .font(TextStyle.title20)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(vacancy.employerCity)
                                .font(TextStyle.text14)

                            HStack(spacing: 8) {
                                Text(vacancy.employerTitle)
                                    .font(TextStyle.title14)

                                if vacancy.isEmployerVerify {
                                    Image(uiImage: AppImage.Icons.employerVerify.image)
                                        .resizable()
                                        .tint(AppColor.grey3.suiColor)
                                        .frame(width: 16, height: 16)
                                }
                            }
                        }

                        if let experience = vacancy.experienceText {
                            HStack(alignment: .center, spacing: 8) {
                                Image(uiImage: AppImage.Icons.suitcase.image)
                                    .resizable()
                                    .frame(width: 16, height: 16)

                                Text(experience)
                                    .font(TextStyle.text14)
                            }
                        }

                        Text(vacancy.publishedAtText)
                            .font(TextStyle.text14)
                            .foregroundStyle(AppColor.grey3.suiColor)
                    }
                    .foregroundStyle(AppColor.Text.main.suiColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                VStack {
                    Button {
                        onTapAddToFavourite?()
                    } label: {
                        Image(
                            uiImage: vacancy.isFavourite
                            ? AppImage.Icons.heartFill.image
                            : AppImage.Icons.heart.image
                        )
                        .resizable()
                        .tint(AppColor.grey4.suiColor)
                        .frame(width: 24, height: 24)
                        .id(vacancy.isFavourite)
                    }
                    .buttonStyle(.borderless)
                }
            }

            Button("Откликнуться") {
                onTapApplyToVacancy?()
            }
            .buttonStyle(CapsuleButtonStyle(verticalPadding: 7))
            .padding(.top, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 16)
        .background(AppColor.bgSecondary.suiColor)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .contentShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - Preview

struct SearchVacancyScreenForRow_Previews: PreviewProvider {
    struct Container: View {
        @StateObject private var diContainer = AppDIContainer()

        var body: some View {
            MainTabView()
                .environmentObject(diContainer)
        }
    }

    static var previews: some View {
        Container()
    }
}

struct VacancyRowView_Previews: PreviewProvider {
    struct Container: View {
        @State var vacancy: VacancyRowViewModel = .init(vacancy: .testVacancy)

        var body: some View {
            VacancyListRowView(vacancy: vacancy)
        }
    }

    static var previews: some View {
        Container()
            .background(.black)
    }

}
