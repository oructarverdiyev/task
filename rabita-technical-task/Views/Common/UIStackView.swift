//
//  UIStackView.swift
//  rabita-technical-task
//
//  Created by Oruc Tarverdiyev on 17.08.24.
//

import UIKit.UIStackView

extension UIStackView {
    convenience init(arrangedSubviews: [UIView] = [],
                     axis: NSLayoutConstraint.Axis,
                     distribution: UIStackView.Distribution = .fill,
                     alignment: UIStackView.Alignment = .fill,
                     spacing: CGFloat = 0
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}
