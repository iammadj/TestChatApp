//
//  MessageInputView.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import UIKit
import TinyConstraints

class MessageInputView: UIView {
    
    //MARK: - Properties
    
    private let vStack = UIStackView(spacing: 0.0)
    private let bottomHStack = UIStackView(axis: .horizontal, spacing: 8.0)
    
    private let textView = UITextView()
    
    private let toolBar: UIToolbar = {
        let toolBar = UIToolbar(
            frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 16.0)
        )
        toolBar.tintColor = .white
        toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolBar.setShadowImage(UIImage(), forToolbarPosition: .any)
        toolBar.isHidden = true
        
        return toolBar
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        button.isEnabled = false
        
        return button
    }()
    
    private let defaultHeight: CGFloat = 40.0
    
    private var topConstraint: NSLayoutConstraint!
    private var heightConstraint: NSLayoutConstraint!
    
    private var inputText = ""
    
    var sendButtonDidTap: ((String) -> Void)?
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MessageInputView: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        setDoneButton(hidden: false)
        let newHeight = heightConstraint.constant * 1.5
        setTopConstraint(constant: 0.0)
        setHeightConstraint(constant: newHeight)
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        inputText = textView.text.orEmpty
        sendButton.isEnabled = !inputText.isEmpty
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        setDoneButton(hidden: true)
        let newHeight = heightConstraint.constant / 1.5
        setTopConstraint(constant: 8.0)
        setHeightConstraint(constant: newHeight)
    }
    
}

//MARK: - Private Methods

extension MessageInputView {
    
    private func setup() {
        backgroundColor = .lightGray
        setupToolBar()
        setupTextView()
        setupSendButton()
    }
    
    private func setupToolBar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done", style: .done) { [weak self] _ in
            self?.textView.resignFirstResponder()
        }
        toolBar.setItems([flexibleSpace, doneBarButton], animated: false)
    }
    
    private func layout() {
        addSubview(vStack)
        vStack.addArrangedSubviews(toolBar, bottomHStack)
        bottomHStack.addArrangedSubviews(textView, sendButton)
                
        vStack.edgesToSuperview(excluding: .top, insets: .horizontal(16.0) + .bottom(8.0))
        topConstraint = vStack.topToSuperview(offset: 8.0)
        heightConstraint = textView.height(defaultHeight, priority: .defaultHigh)
    }
    
    private func setupTextView() {
        textView.delegate = self
        textView.roundCorners(radius: 8.0)
    }
    
    private func setupSendButton() {
        sendButton.addTarget { [weak self] _ in
            let inputText = self?.inputText
            self?.textView.resignFirstResponder()
            self?.textView.text = ""
            self?.sendButtonDidTap?(inputText.orEmpty)
        }
    }
    
    private func setDoneButton(hidden: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.toolBar.isHidden = hidden
            self.layoutIfNeeded()
        }
    }
    
    private func setTopConstraint(constant: CGFloat) {
        topConstraint.isActive = false
        topConstraint.constant = constant
        topConstraint.isActive = true
    }
    
    private func setHeightConstraint(constant: CGFloat) {
        heightConstraint.isActive = false
        heightConstraint.constant = constant
        heightConstraint.isActive = true
    }
    
}
