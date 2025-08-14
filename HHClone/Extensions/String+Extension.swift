import Foundation
import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        guard let first = self.first else { return self }
        return first.uppercased() + self.dropFirst()
    }

    func attributedString(from html: String, with font: UIFont) -> AttributedString? {
        guard let data = html.data(using: .utf8) else { return nil }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        if let nsAttributedString = try? NSMutableAttributedString(
            data: data,
            options: options,
            documentAttributes: nil
        ) {
            nsAttributedString.addAttribute(
                .font,
                value: font,
                range: NSRange(location: 0, length: nsAttributedString.length)
            )
            return try? AttributedString(nsAttributedString, including: \.foundation)
        }

        return nil
    }

}
