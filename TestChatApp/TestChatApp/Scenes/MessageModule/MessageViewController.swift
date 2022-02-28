//
//  MessageViewController.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 26/02/22.
//

import UIKit
import TinyConstraints
import SendBirdSDK

protocol MessageViewProtocol: BaseViewProtocol {
    
    func eneteredToChannel(_ channelName: String)
    func didReceiveMessages(_ messages: [String])
    func didReceive(message: String)
    func reload()
   
}

class MessageViewController: BaseViewController, KeyboardMoveable {
    
    //MARK: - Properties
    
    var presenter: MessageViewPresenterProtocol? {
        _presenter as? MessageViewPresenterProtocol
    }
    
    var keyboardHeight: CGFloat = 0.0
    lazy var defaultBottomInset: CGFloat = view.safeAreaInsets.bottom
    var bottomInsetLC: NSLayoutConstraint { bottomConstraint }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
        tableView.contentInset = UIEdgeInsets(top: 16.0, left: 0.0, bottom: 24.0, right: 0.0)
        tableView.dataSource = self
        tableView.register(MessageTableViewCell.self)
        
        return tableView
    }()
    
    private lazy var showInfoBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle")) { [weak self] _ in
            self?.presenter?.routeToParticipantsView()
        }
        
        return button
    }()
        
    private let messageInputView = MessageInputView()
    
    private var identifier: String { String(describing: self) }
    
    private var bottomConstraint: NSLayoutConstraint!
    
    private var messages: [String] = []
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRightBarButton()
        layout()
        addKeyboardListeners()
        handleTextViewTextChanges()
        SBDMain.add(self as SBDChannelDelegate, identifier: identifier)
    }
    
    deinit {
        removeKeyboardListeners()
        SBDMain.removeChannelDelegate(forIdentifier: identifier)
    }
    
}

//MARK: - SendBird Delegate

extension MessageViewController: SBDChannelDelegate {
    
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        messages.append(message.message)
        reload()
    }
    
}

//MARK: - View Protocol Implementation

extension MessageViewController: MessageViewProtocol {
    
    func eneteredToChannel(_ channelName: String) {
        title = channelName
        presenter?.fetchPrevMessages()
    }
    
    func didReceiveMessages(_ messages: [String]) {
        self.messages = messages
        tableView.reloadData()
        tableView.scrollToBottom(animated: false)
    }
    
    func didReceive(message: String) {
        messages.append(message)
        tableView.reloadData()
        tableView.scrollToBottom(animated: true)
    }
    
    func reload() {
        tableView.reloadData()
    }
    
}

//MARK: - TableView DataSource

extension MessageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MessageTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let message = messages[indexPath.row]
        cell.configure(with: message)
        
        return cell
    }
    
}

//MARK: - Private Methods

extension MessageViewController {
    
    private func setRightBarButton() {
        navigationItem.rightBarButtonItem = showInfoBarButtonItem
    }
    
    private func layout() {
        view.addSubviews(tableView, messageInputView)
        tableView.topToSuperview(usingSafeArea: true)
        tableView.horizontalToSuperview()
        
        messageInputView.topToBottom(of: tableView)
        messageInputView.horizontalToSuperview()
        bottomConstraint = messageInputView.bottomToSuperview(usingSafeArea: true)
    }
    
    private func handleTextViewTextChanges() {
        messageInputView.sendButtonDidTap = { [weak self] text in
            self?.presenter?.sendMessage(text)
        }
    }
    
}
