import UIKit

extension UIStackView {

    convenience init(distribution: UIStackViewDistribution = UIStackViewDistribution.fill, alignment: UIStackViewAlignment = UIStackViewAlignment.fill, axis: UILayoutConstraintAxis = UILayoutConstraintAxis.horizontal, spacing: CGFloat = 0.0) {
        self.init()

        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
    }

}

extension UIStackView {

    func add(toScrollView scrollView: UIScrollView) {
        scrollView.addSubview(self)
        self.pin(toScrollView: scrollView)
    }

    func pin(toScrollView scrollView: UIScrollView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

}
