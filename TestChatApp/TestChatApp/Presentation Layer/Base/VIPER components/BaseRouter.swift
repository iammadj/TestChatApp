//
//  BaseRouter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import UIKit.UIViewController

protocol BaseRouterProtocol: AnyObject { }

class BaseRouter {
    
    //MARK: - Properties
    
    weak var _view: BaseViewProtocol?
    
    var viewController: UIViewController? {
        _view as? UIViewController
    }
    
    var navigationController: UINavigationController? {
        viewController?.navigationController
    }
    
    //MARK: - Methods
    
    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        self.viewController?.present(viewController, animated: animated, completion: completion)
    }
    
    func show(_ viewController: UIViewController, sender: Any? = nil) {
        self.viewController?.show(viewController, sender: sender)
    }
    
    func dismiss(_ completion: (() -> Void)? = nil) {
        self.viewController?.dismiss(animated: true, completion: completion)
    }
    
}
