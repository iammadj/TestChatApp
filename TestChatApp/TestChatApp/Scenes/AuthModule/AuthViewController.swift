//
//  AuthViewController.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import UIKit
import TinyConstraints
import RxSwift

protocol AuthViewProtocol: BaseViewProtocol {
   
}

class AuthViewController: BaseViewController {
    
    //MARK: - Properties
    
    var presenter: AuthViewPresenterProtocol? {
        _presenter as? AuthViewPresenterProtocol
    }
        
    private let loginTextFieldView: LabeledTextFieldView = {
        let textFieldView = LabeledTextFieldView()
        textFieldView.setTitle("Login")
        
        return textFieldView
    }()
    
    private let loginButton: RoundedButton = {
        let button = RoundedButton()
        button.setTitle("Connect", for: .normal)
        button.isEnabled = false
        button.height(48.0)
        
        return button
    }()

    private var loginText: String?
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleTextEditings()
        addActionForLoginButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

//MARK: - View Protocol Implementation

extension AuthViewController: AuthViewProtocol {
    
}


//MARK: - Private Methods

extension AuthViewController {
    
    override func embedSubviews() {
        view.addSubviews(loginTextFieldView, loginButton)
    }
    
    override func setSubviewsConstraints() {
        loginTextFieldView.horizontalToSuperview(insets: .horizontal(16.0))
        loginTextFieldView.topToSuperview(offset: 64.0, usingSafeArea: true)
        
        loginButton.topToBottom(of: loginTextFieldView, offset: 32.0)
        loginButton.horizontalToSuperview(insets: .horizontal(16.0))
        loginButton.bottomToSuperview(offset: -32.0, relation: .equalOrLess, usingSafeArea: true)
    }
    
    private func handleTextEditings() {
        loginTextFieldView.textDidChange = { [weak self] login in
            self?.loginText = login
            self?.validateLoginButton()
        }
    }
    
    private func validateLoginButton() {
        loginButton.isEnabled = !(loginText.orEmpty.isEmpty)
    }
    
    private func addActionForLoginButton() {
        loginButton.addTarget { [weak self] _ in
            guard let self = self else { return }
            self.presenter?.connect(withUserID: self.loginText.orEmpty)
        }
    }
    
}
