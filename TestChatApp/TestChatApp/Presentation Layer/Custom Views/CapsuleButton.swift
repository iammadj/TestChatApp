//
//  CapsuleButton.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 23/02/22.
//

import UIKit

class CapsuleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        if #available(iOS 15.0, *) {
            configuration = .plain()
            configuration?.cornerStyle = .capsule
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
            let radius = bounds.height / 2
            roundCorners(radius: radius)
        }
    }

}
