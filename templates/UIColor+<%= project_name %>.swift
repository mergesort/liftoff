//
//  UIColor+<%= project_name %>.swift
//  <%= project_name %>
//
//  Created by <%= author %> on <%= Time.now.strftime("%-m/%-d/%y") %>
//  Copyright (c) <%= Time.now.strftime('%Y') %> <%= company %>. All rights reserved.
//

import UIKit

public extension UIColor {

    public static var paletteBlack: UIColor {
        return #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1) // #222222
    }

    public static var paletteWhite: UIColor {
        return #colorLiteral(red: 0.9960784314, green: 0.9960784314, blue: 0.9960784314, alpha: 1) // #FEFEFE
    }

}

public extension UIColor {

    convenience init(rgba: String) {
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
            red = CGFloat(hexValue & 0xFF000000) / 255.0
            green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
            alpha = CGFloat(hexValue & 0x000000FF) / 255.0

        default:
            alpha = defaultValue
            red = defaultValue
            green = defaultValue
            blue = defaultValue
        }

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

}
