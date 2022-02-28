//
//  UsersViewController.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import UIKit
import TinyConstraints

protocol UsersViewProtocol: BaseViewProtocol {
    
    func fetchedUsers(_ users: [UserViewModel])
    func reload()
   
}

class UsersViewController: BaseViewController {
    
    //MARK: - Properties
    
    var presenter: UsersViewPresenterProtocol? {
        _presenter as? UsersViewPresenterProtocol
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInset = UIEdgeInsets(top: 16.0, left: 0.0, bottom: 24.0, right: 0.0)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserTableViewCell.self)
        
        return tableView
    }()
    
    private let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.tintColor = .blue
        
        return toolBar
    }()
    
    private var users: [UserViewModel] = []
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupToolBar()
        layout()
    }
    
}

//MARK: - View Protocol Implementation

extension UsersViewController: UsersViewProtocol {
    
    func fetchedUsers(_ users: [UserViewModel]) {
        self.users = users
        reload()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let user = users[indexPath.row]
        cell.configure(with: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        users.forEach { $0.isSelected = false }
        users[indexPath.row].isSelected = true
        reload()
    }
    
}

//MARK: - Private Methods

extension UsersViewController {
    
    private func setupToolBar() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "Done") { [weak self] _ in
            guard let self = self else { return }
            let selectedUserId = self.users.first(where: { $0.isSelected })?.id
            self.presenter?.didSelect(userID: selectedUserId.orEmpty)
        }
        
        toolBar.setItems([flexibleSpace, doneBarButton], animated: false)
    }
    
    private func layout() {
        view.addSubviews(toolBar, tableView)
        
        toolBar.topToSuperview(usingSafeArea: true)
        toolBar.horizontalToSuperview()
        toolBar.height(40.0)
        
        tableView.topToBottom(of: toolBar)
        tableView.edgesToSuperview(excluding: .top)
    }
    
}
