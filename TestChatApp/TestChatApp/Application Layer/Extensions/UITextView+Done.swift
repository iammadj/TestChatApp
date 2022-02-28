//
//  UITextView+Done.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import UIKit

extension UITextView {
    
    func addDoneButton(title: String, _ completion: @escaping (UIBarButtonItem) -> Void) {
        let toolBar = UIToolbar(
            frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0)
        )
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, closure: completion)
        toolBar.setItems([flexibleSpace, barButton], animated: false)
        toolBar.tintColor = .blue
        self.inputAccessoryView = toolBar
    }
    
    func addDoneButton(title: String) {
        let toolBar = UIToolbar(
            frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0)
        )
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: title) { [weak self] _ in
            self?.resignFirstResponder()
        }
        toolBar.setItems([flexibleSpace, doneBarButton], animated: false)
        toolBar.tintColor = .blue
        self.inputAccessoryView = toolBar
    }
    
}
