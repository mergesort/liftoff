import UIKit

public extension UIColor {

    /// This initializer takes in an rgba string long, and returns a UIColor.
    ///
    /// - Parameter rgba: An rgba color string, with a leading # or not, either 6 or 8 characters.
    /// See [here](http://www.w3schools.com/cssref/css_colors_legal.asp) for proper formatting notes.
    public convenience init(rgba: String) {
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat
        let hex: String

        if rgba.hasPrefix("#") {
            let index = rgba.characters.index(rgba.startIndex, offsetBy: 1)
            hex = rgba.substring(from: index)
        } else {
            hex = rgba
        }

        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong
        hexValue = 0

        let defaultValue: CGFloat = 1.0

        guard scanner.scanHexInt64(&hexValue) else {
            self.init(red: defaultValue, green: defaultValue, blue: defaultValue, alpha: defaultValue)
            return
        }

        switch hex.characters.count {

        case 6:
            red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(hexValue & 0x0000FF) / 255.0
            alpha = 1.0

        case 8:
            red = CGFloat(hexValue & 0xFF00_0000) / 255.0
            green = CGFloat((hexValue & 0x00FF_0000) >> 16) / 255.0
            blue = CGFloat((hexValue & 0x0000_FF00) >> 8) / 255.0
            alpha = CGFloat(hexValue & 0x0000_00FF) / 255.0

        default:
            alpha = defaultValue
            red = defaultValue
            green = defaultValue
            blue = defaultValue
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// Returns a hexadecimal `String` representation of a `UIColor`.
    public var hex: String {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0

        self.getRed(&r, green: &g, blue: &b, alpha: &a)

        if a == 0 {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        } else {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        }
    }
}

extension UIColor {

    public func lightened(byPercentage percentage: CGFloat = 0.2) -> UIColor {
        return self.changedBrightness(byPercentage: percentage) ?? UIColor.white
    }

    public func darkened(byPercentage percentage: CGFloat = 0.2) -> UIColor {
        return self.changedBrightness(byPercentage: -percentage) ?? UIColor.black
    }
}

private extension UIColor {

    func hsba() -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)? {
        var hue: CGFloat = .nan
        var saturation: CGFloat = .nan
        var brightness: CGFloat = .nan
        var alpha: CGFloat = .nan

        guard self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else {
            return nil
        }

        return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    func changedBrightness(byPercentage percent: CGFloat) -> UIColor? {
        guard percent != 0 else {
            return self.copy() as? UIColor
        }

        guard let hsba = self.hsba() else {
            return nil
        }

        let percentage: CGFloat = min(max(percent, -1), 1)
        let newBrightness = min(max(hsba.brightness + percentage, -1), 1)
        return UIColor(hue: hsba.hue, saturation: hsba.saturation, brightness: newBrightness, alpha: hsba.alpha)
    }
}
