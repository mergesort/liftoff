//
//  UIFont+<%= project_name %>.swift
//  <%= project_name %>
//
//  Created by <%= author %> on <%= Time.now.strftime("%-m/%-d/%y") %>
//  Copyright (c) <%= Time.now.strftime('%Y') %> <%= company %>. All rights reserved.
//

import UIKit

extension UIFont {

    static func regularFontOfSize(size: Float) -> UIFont {
        return UIFont.systemFontOfSize(CGFloat(size))
    }

    static func lightFontOfSize(size: Float) -> UIFont {
        return UIFont.systemFontOfSize(CGFloat(size), weight: UIFontWeightLight)
    }

    static func heavyFontOfSize(size: Float) -> UIFont {
        return UIFont.systemFontOfSize(CGFloat(size), weight: UIFontWeightSemibold)
    }
    
}
