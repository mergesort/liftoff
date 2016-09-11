//
//  UIFont+<%= project_name %>.swift
//  <%= project_name %>
//
//  Created by <%= author %> on <%= Time.now.strftime("%-m/%-d/%y") %>
//  Copyright (c) <%= Time.now.strftime('%Y') %> <%= company %>. All rights reserved.
//

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

    static func <%= project_name %>Font(_ style: FontStyle, size: CGFloat) -> UIFont? {
        return UIFont(name: style.fontName, size: size)
    }

}
