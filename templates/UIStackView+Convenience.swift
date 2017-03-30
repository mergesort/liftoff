import UIKit

extension UIStackView {

    /// A convenience initializer allowing you to create a `UIStackView` with the properties
    /// which are commonly setup for `UIStackView`.
    convenience init(distribution: UIStackViewDistribution = UIStackViewDistribution.fill, alignment: UIStackViewAlignment = UIStackViewAlignment.fill, axis: UILayoutConstraintAxis = UILayoutConstraintAxis.horizontal, spacing: CGFloat = 0.0) {
        self.init()

        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }
}

extension UIStackView {

    /// This function allows you to adds a `UIStackView` to a `UIScrollView` and pins it's anchors
    /// their anchors to match.
    ///
    /// - Parameters:
    ///   - scrollView: The UIScrollView to pin the `UIStackView` to.
    ///   - axis: The direction to pin, which will be the opposite of the scrolling direction.
    func add(toScrollView scrollView: UIScrollView, axis: UILayoutConstraintAxis = .vertical) {
        scrollView.addSubview(self)
        self.pin(toScrollView: scrollView, axis: axis)
    }

    /// This function takes a `UIStackView` and sets it's anchors to match a `UIScrollView`.
    /// This allows users to easily create stackViews that scroll, without boilerplate.
    ///
    /// - Parameters:
    ///   - scrollView: The `UIScrollView` to pin the `UIStackView` to.
    ///   - axis: The direction to pin, which will be the opposite of the scrolling direction.
    func pin(toScrollView scrollView: UIScrollView, axis: UILayoutConstraintAxis = .vertical) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        if case .vertical = axis {
            self.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        } else {
            self.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        }
    }
}
