//
//  BaseViewController.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import UIKit.UIViewController

protocol BaseViewProtocol: AnyObject {}

class BaseViewController: UIViewController {
    
    //MARK: - Properties
    
    var _presenter: BasePresenterProtocol?
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        _presenter?.viewDidLoad()
    }
    
}

@objc extension BaseViewController {
    
    public func setupSubviews() {
        embedSubviews()
        setSubviewsConstraints()
    }
    
    public func embedSubviews() {}
    
    public func setSubviewsConstraints() {}
    
}
