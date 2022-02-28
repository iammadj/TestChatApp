//
//  UIView+AddSubviews.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 23/02/22.
//

import UIKit.UIView

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
}

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
    
}
