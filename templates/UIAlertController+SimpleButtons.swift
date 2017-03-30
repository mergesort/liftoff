import UIKit

extension UIAlertController {

    /// A convenient cancel action to add onto `UIAlertController`
    ///
    /// - Parameter handler: An optional block to call when cancel is tapped
    func addCancelAction(handler: ((UIAlertAction) -> Void)? = nil) {
        self.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: handler))
    }

    /// A convenient done action to add onto `UIAlertController`
    ///
    /// - Parameter handler: An optional block to call when done is tapped
    func addDoneAction(handler: ((UIAlertAction) -> Void)? = nil) {
        self.addAction(UIAlertAction(title: NSLocalizedString("Done", comment: "Done"), style: .cancel, handler: handler))
    }

    /// A convenient okay action to add onto `UIAlertController`
    ///
    /// - Parameter handler: An optional block to call when okay is tapped
    func addOkayAction(handler: ((UIAlertAction) -> Void)? = nil) {
        self.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: .cancel, handler: handler))
    }
}
