//
//  KeyboardMoveable.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import UIKit

protocol KeyboardMoveable: UIViewController {
    
    var keyboardHeight: CGFloat { get set }
    var defaultBottomInset: CGFloat { get set }
    var activeKeyboardBottomInset: CGFloat { get }
    var bottomInsetLC: NSLayoutConstraint { get }
    
    func addKeyboardListeners()
    func removeKeyboardListeners()
    func keyboardWillShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
    func setBottomInset(_ inset: CGFloat)
    
}

extension KeyboardMoveable {
    
    var activeKeyboardBottomInset: CGFloat { keyboardHeight }
    
    func addKeyboardListeners() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
                self?.keyboardWillShow(notification)
        }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
                self?.keyboardWillHide(notification)
        }
    }
    
    func removeKeyboardListeners() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            setBottomInset(activeKeyboardBottomInset)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        setBottomInset(defaultBottomInset)
    }
    
    func setBottomInset(_ inset: CGFloat) {
        bottomInsetLC.constant = -(inset - view.safeAreaInsets.bottom)
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
}
