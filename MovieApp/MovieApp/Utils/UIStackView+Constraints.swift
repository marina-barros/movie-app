//
//  UIStackView+Constraints.swift
//  MovieApp
//
//  Created by Marina Barros on 21/01/24.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            self.addArrangedSubview(view)
        }
    }
}
