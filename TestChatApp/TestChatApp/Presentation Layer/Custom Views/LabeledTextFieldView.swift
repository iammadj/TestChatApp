//
//  LabeledTextFieldView.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 23/02/22.
//

import UIKit
import TinyConstraints

class LabeledTextFieldView: BaseView, UITextFieldDelegate {
    
    //MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.height(48.0)
        
        return textField
    }()
    
    public var textDidChange: ((String?) -> Void)?
    
    //MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    public func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    override func embedSubviews() {
        addSubviews(titleLabel, textField)
    }
    
    override func setSubviewsConstraints() {
        titleLabel.edgesToSuperview(excluding: .bottom)
        
        textField.topToBottom(of: titleLabel, offset: 8.0)
        textField.edgesToSuperview(excluding: .top)
    }
    
    //MARK: - Private Methods
    
    private func setup() {
        textField.delegate = self
        textField.addTarget { [weak self] textField in
            self?.textDidChange?(textField.text)
        }
    }
    
    //MARK: - Delegate Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
