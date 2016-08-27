//
//  Loggable.swift
//  <%= project_name %>
//
//  Created by <%= author %> on <%= Time.now.strftime("%-m/%-d/%y") %>
//  Copyright (c) <%= Time.now.strftime('%Y') %> <%= company %>. All rights reserved.
//

import Foundation

protocol Loggable {

    func setup()

    static func verbose(message: AnyObject)
    static func debug(message: AnyObject)
    static func info(message: AnyObject)
    static func warning(message: AnyObject)
    static func error(message: AnyObject)

}
