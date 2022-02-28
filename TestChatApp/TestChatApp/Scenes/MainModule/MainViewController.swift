//
//  MainViewController.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 19/02/22.
//

import UIKit
import TinyConstraints

protocol MainViewProtocol: BaseViewProtocol {
    
    
    func fetchedChannels(_ channels: [ChannelViewModel])
    func newChannelCreated(_ channel: ChannelViewModel)
    func reload()
   
}

class MainViewController: BaseViewController {
    
    //MARK: - Properties
    
    var presenter: MainViewPresenterProtocol? {
        _presenter as? MainViewPresenterProtocol
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
        tableView.contentInset = UIEdgeInsets(top: 16.0, left: 0.0, bottom: 24.0, right: 0.0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainViewTableViewCell.self)
        
        return tableView
    }()
    
    private lazy var createNewChannelBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus.bubble")) { [weak self] _ in
            self?.createNewChannel()
        }
        
        return button
    }()
    
    
    private var channels: [ChannelViewModel] = []
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        setRightBarButtonItem()
    }
    
}

//MARK: - View Protocol Implementation

extension MainViewController: MainViewProtocol {
    
    func fetchedChannels(_ channels: [ChannelViewModel]) {
        title = "Channels"
        self.channels = channels
        reload()
    }
    
    func newChannelCreated(_ channel: ChannelViewModel) {
        channels.insert(channel, at: 0)
        reload()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
}

//MARK: - TableView DataSource

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MainViewTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let channel = channels[indexPath.row]
        cell.configure(with: channel.name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channelURL = channels[indexPath.row].url
        presenter?.routeToMessageView(with: channelURL)
    }
    
}

//MARK: - Private Methods

extension MainViewController {
    
    private func layout() {
        view.addSubview(tableView)
        tableView.edgesToSuperview(excluding: .top)
        tableView.topToSuperview(usingSafeArea: true)
    }
    
    private func setRightBarButtonItem() {
        navigationItem.rightBarButtonItem = createNewChannelBarButtonItem
    }
    
    private func createNewChannel() {
        let channel = ChannelViewModel(url: "", name: "", countOfParticipants: 0)
        
        showAlert(
            title: "Enter New Channel Credits",
            actionTitle: "Create",
            isActionEnabled: false,
            actionHandler: { [weak self] _ in
                self?.presenter?.createNewChannel(url: channel.url, name: channel.name)
            },
            textFieldPlaceholer: "Channel URL (Optional)",
            textFieldTextHandler: { channel.url = $0 },
            secondaryTextFieldPlaceholder: "Channel name",
            secondaryTextFieldTextHandler: { channel.name = $0 },
            secondaryTextFieldShouldValidateAction: true,
            cancellable: true
        )
    }
    
}
