import UIKit

extension UIViewController {

    /// This function adds a `UIViewController` as a childViewController,
    /// and calls the appropriate lifecycle methods.
    ///
    /// - Parameter childViewController: The childViewController to add to the view.
    func add(childViewController: UIViewController) {
        self.addChildViewController(childViewController)
        self.view.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: self)
    }

    /// This function inserts a `UIViewController` as a childViewController below a subview,
    /// and calls the appropriate lifecycle methods.
    ///
    /// - Parameters:
    ///   childViewController: The childViewController to insert into the view.
    ///   - index: The subview to insert the childViewController below.
    func insert(childViewController: UIViewController, belowSubview subview: UIView) {
        self.addChildViewController(childViewController)
        self.view.insertSubview(childViewController.view, belowSubview: subview)
        childViewController.didMove(toParentViewController: self)
    }

    /// This function inserts a `UIViewController` as a childViewController above a subview,
    /// and calls the appropriate lifecycle methods.
    ///
    /// - Parameters:
    ///   childViewController: The childViewController to insert into the view.
    ///   - index: The subview to insert the childViewController above.
    func insert(childViewController: UIViewController, aboveSubview subview: UIView) {
        self.addChildViewController(childViewController)
        self.view.insertSubview(childViewController.view, aboveSubview: subview)
        childViewController.didMove(toParentViewController: self)
    }

    /// This function inserts a `UIViewController` as a childViewController at an index,
    /// and calls the appropriate lifecycle methods.
    ///
    /// - Parameters:
    ///   childViewController: The childViewController to insert into the view.
    ///   - index: The index at which to insert the childViewController.
    func insert(childViewController: UIViewController, at index: Int) {
        self.addChildViewController(childViewController)
        self.view.insertSubview(childViewController.view, at: index)
        childViewController.didMove(toParentViewController: self)
    }

    /// This function removes a childViewController from it's parent,
    /// and calls the appropriate lifecycle methods.
    func removeFromParent() {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}
