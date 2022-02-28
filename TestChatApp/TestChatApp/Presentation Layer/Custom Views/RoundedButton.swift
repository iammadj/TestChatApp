//
//  RoundedButton.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 23/02/22.
//

import UIKit

class RoundedButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 15.0, *) {
            configuration = .plain()
            configuration?.background.cornerRadius = 16.0
            configuration?.background.backgroundColor = .systemBlue
        } else {
            backgroundColor = .systemBlue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if #available(iOS 15.0, *) {
            return
        } else {
            roundCorners(radius: 16.0)
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            let bgColor: UIColor = isEnabled ? .systemBlue : .systemGray
            setBackgroundColor(bgColor)
        }
    }
    
    public func setBackgroundColor(_ color: UIColor) {
        if #available(iOS 15.0, *) {
            configuration?.background.backgroundColor = color
        } else {
            backgroundColor = color
        }
    }

}
