//
//  UIViewController+ShowAlert.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import UIKit.UIViewController

extension UIViewController {
    
    func showAlert(
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert,
        actionTitle: String? = nil,
        isActionEnabled: Bool = true,
        actionHandler: ((UIAlertAction) -> Void)? = nil,
        secondaryActionTitle: String? = nil,
        isSecondaryActionEnabled: Bool = true,
        secondaryActionHandler: ((UIAlertAction) -> Void)? = nil,
        textFieldPlaceholer: String? = nil,
        textFieldTextHandler: ((String) -> Void)? = nil,
        textFieldShouldValidateAction: Bool = false,
        secondaryTextFieldPlaceholder: String? = nil,
        secondaryTextFieldTextHandler: ((String) -> Void)? = nil,
        secondaryTextFieldShouldValidateAction: Bool = false,
        cancellable: Bool = false
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        var action: UIAlertAction?
        var secondaryAction: UIAlertAction?
        
        var isActionEnabled = isActionEnabled {
            didSet {
                if action != nil {
                    action?.isEnabled = isActionEnabled
                }
            }
        }
        
        if let actionTitle = actionTitle {
            action = UIAlertAction(title: actionTitle, style: .default) { action in
                actionHandler?(action)
            }
            action?.isEnabled = isActionEnabled
            alertController.addAction(action!)
        }
        
        if let secondaryActionTitle = secondaryActionTitle {
            secondaryAction = UIAlertAction(title: secondaryActionTitle, style: .default) { action in
                secondaryActionHandler?(action)
            }
            secondaryAction?.isEnabled = isSecondaryActionEnabled
            alertController.addAction(secondaryAction!)
        }
        
        if cancellable {
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancel)
        }
        
        if let textFieldPlaceholer = textFieldPlaceholer {
            alertController.addTextField { textField in
                textField.placeholder = textFieldPlaceholer
                textField.addTarget { input in
                    textFieldTextHandler?(input.text.orEmpty)
                }
            }
        }
        
        if let secondaryTextFieldPlaceholder = secondaryTextFieldPlaceholder {
            alertController.addTextField { textField in
                textField.placeholder = secondaryTextFieldPlaceholder
                textField.addTarget { input in
                    secondaryTextFieldTextHandler?(input.text.orEmpty)
                    if secondaryTextFieldShouldValidateAction {
                        isActionEnabled = !input.text.orEmpty.isEmpty
                    }
                }
            }
        }
                
        present(alertController, animated: true, completion: nil)
    }
    
}
