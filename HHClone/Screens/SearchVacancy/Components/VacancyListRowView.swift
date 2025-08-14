import SwiftUI

struct VacancyListRowView: View {

    @Binding private var vacancy: Vacancy
    private var onTapAddToFavourite: (() -> Void)?
    private var onTapApplyToVacancy: (() -> Void)?

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(spacing: 10) {
                    Group {
                        Text("Сейчас просматривает 1 человек")
                            .font(TextStyle.title14)
                            .foregroundStyle(AppColor.Text.green.suiColor)

                        Text(vacancy.title)
                            .font(TextStyle.title16)
                            .fixedSize(horizontal: false, vertical: true)


//                        if let salaryText = vacancy.salaryRangeText {
//                            Text("\(salaryText)")
//                                .font(TextStyle.title20)
//                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(vacancy.address.city)
                                .font(TextStyle.text14)

                            HStack(spacing: 8) {
                                Text(vacancy.employerTitle)
                                    .font(TextStyle.title14)

                                Image(uiImage: AppImage.Icons.employerVerify.image)
                                    .resizable()
                                    .tint(AppColor.grey3.suiColor)
                                    .frame(width: 16, height: 16)
                            }
                        }

                        if let experienceText {
                            HStack(alignment: .center, spacing: 8) {
                                Image(uiImage: AppImage.Icons.suitcase.image)
                                    .resizable()
                                    .frame(width: 16, height: 16)

                                Text(experienceText)
                                    .font(TextStyle.text14)
                            }
                        }

                        Text("Опубликовано 14 февраля")
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

    init(
        vacancy: Binding<Vacancy>,
        onTapAddToFavourite: (() -> Void)? = nil,
        onTapApplyToVacancy: (() -> Void)? = nil
    ) {
        self._vacancy = vacancy
        self.onTapAddToFavourite = onTapAddToFavourite
        self.onTapApplyToVacancy = onTapApplyToVacancy
    }

    // MARK: - Prepare data

    var experienceText: String? {
        guard let experience = vacancy.experience else { return nil }

        if experience == .no {
            return experience.text.capitalizingFirstLetter()
        } else {
            return "Опыт \(experience.text)"
        }
    }

}

// MARK: - Preview

struct VacancyRowView_Previews: PreviewProvider {
    struct Container: View {
        @State var vacancy: Vacancy = .testVacancy

        var body: some View {
            VacancyListRowView(vacancy: $vacancy)
        }
    }

    static var previews: some View {
        Container()
            .padding(.vertical, 150)
            .background(.black)
    }

}
