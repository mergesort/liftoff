import Foundation

protocol Loggable {

    static func setup()

    static func verbose(_ message: Any)
    static func debug(_ message: Any)
    static func info(_ message: Any)
    static func warning(_ message: Any)
    static func error(_ message: Any)

}
