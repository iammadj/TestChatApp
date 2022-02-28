//
//  UIStackView+Init.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 23/02/22.
//

import UIKit.UIView

extension UIStackView {
    
    convenience init(
        axis: NSLayoutConstraint.Axis = .vertical,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        spacing: CGFloat
    ) {
        self.init()
        
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
}
