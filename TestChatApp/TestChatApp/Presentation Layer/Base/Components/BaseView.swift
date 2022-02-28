//
//  BaseView.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 23/02/22.
//

import UIKit

public class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupSubviews() {
        embedSubviews()
        setSubviewsConstraints()
    }
    
    public func embedSubviews() {}
    
    public func setSubviewsConstraints() {}

}
