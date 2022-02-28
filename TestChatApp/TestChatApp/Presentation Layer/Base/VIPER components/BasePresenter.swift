//
//  BasePresenter.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import Foundation

protocol BasePresenterProtocol: AnyObject {
    
    init(view: BaseViewProtocol, interactor: BaseInteractorProtocol, router: BaseRouterProtocol)
    
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    
}

extension BasePresenterProtocol {
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewWillDisappear() {}
    
}

class BasePresenter {
    
    weak var _view: BaseViewProtocol?
    var _interactor: BaseInteractorProtocol?
    var _router: BaseRouterProtocol?
    
}
