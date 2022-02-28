//
//  ChannelParticipantsViewController.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 28/02/22.
//

import UIKit

protocol ChannelParticipantsViewProtocol: BaseViewProtocol {
    
    func fetchedParticipants(_ users: [UserViewModel])
   
}

class ChannelParticipantsViewController: BaseViewController {
    
    //MARK: - Properties
    
    var presenter: ChannelParticipantsViewPresenterProtocol? {
        _presenter as? ChannelParticipantsViewPresenterProtocol
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
        tableView.contentInset = UIEdgeInsets(top: 16.0, left: 0.0, bottom: 24.0, right: 0.0)
        tableView.dataSource = self
        tableView.register(ChannelParticipantTableViewCell.self)
        
        return tableView
    }()
    
    private var users: [UserViewModel] = []
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Participants"
        layout()
    }
    
}

//MARK: - View Protocol Implementation

extension ChannelParticipantsViewController: ChannelParticipantsViewProtocol {
    
    func fetchedParticipants(_ users: [UserViewModel]) {
        self.users = users
        tableView.reloadData()
    }
    
}

extension ChannelParticipantsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChannelParticipantTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let user = users[indexPath.row]
        cell.configure(username: user.nickname ?? user.id, lastSeen: user.lastSeen)
        
        return cell
    }
    
}

//MARK: - Private Methods

extension ChannelParticipantsViewController {
    
    private func layout() {
        view.addSubview(tableView)
        tableView.edgesToSuperview(excluding: .top)
        tableView.topToSuperview(usingSafeArea: true)
    }
    
}
