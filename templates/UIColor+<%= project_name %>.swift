//
//  UIColor+<%= project_name %>.swift
//  <%= project_name %>
//
//  Created by <%= author %> on <%= Time.now.strftime("%-m/%-d/%y") %>
//  Copyright (c) <%= Time.now.strftime('%Y') %> <%= company %>. All rights reserved.
//

import UIKit

import UIKit

extension UIColor {

    public static var paletteBlack: UIColor {
        return UIColor(argb: "222222")
    }

    public static var paletteWhite: UIColor {
        return UIColor(argb: "FEFEFE")
    }

}

private extension UIColor {

    convenience init(argb: String) {
        let red: CGFloat
        let green: CGFloat
        let blue: CGFloat
        let alpha: CGFloat
        let hex: String

        if argb.hasPrefix("#") {
            let index = argb.startIndex.advancedBy(1)
            hex = argb.substringFromIndex(index)
        } else {
            hex = argb
        }

        let scanner = NSScanner(string: hex)
        var hexValue: CUnsignedLongLong
        hexValue = 0

        if scanner.scanHexLongLong(&hexValue) {
            switch hex.characters.count {

            case 6:
                red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(hexValue & 0x0000FF) / 255.0
                alpha = 1.0

            case 8:
                alpha = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                red = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
                blue = CGFloat(hexValue & 0x000000FF) / 255.0

            default:
                alpha = 1.0
                red = 1.0
                green = 1.0
                blue = 1.0
            }
        } else {
            alpha = 1.0
            red = 1.0
            green = 1.0
            blue = 1.0
        }
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
