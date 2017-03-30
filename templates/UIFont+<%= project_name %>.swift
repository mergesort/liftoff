import UIKit

enum FontStyle {

    case light
    case regular
    case heavy

}

private extension FontStyle {

    var fontName: String {
        switch self {

        case .light:
            return ""

        case .regular:
            return ""

        case .heavy:
            return ""

        }

    }

}

extension UIFont {

    convenience init?(style: FontStyle, size: CGFloat) {
        let fontAttributes: [String: Any] = [
            UIFontDescriptorNameAttribute: style.fontName,
        ]

        let descriptor = UIFontDescriptor(fontAttributes: fontAttributes)

        self.init(descriptor: descriptor, size: size)
    }
}
