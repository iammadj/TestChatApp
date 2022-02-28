//
//  ChannelParticipantTableViewCell.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 28/02/22.
//

import UIKit
import TinyConstraints

class ChannelParticipantTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue.withAlphaComponent(0.3)
        view.roundCorners(radius: 16.0)
        
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
        
    private let lastSeenLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    //MARK: - Init & Life cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        usernameLabel.text = nil
        lastSeenLabel.text = nil
    }
    
    //MARK: - Methods
    
    private func layout() {
        contentView.addSubview(containerView)
        containerView.addSubviews(usernameLabel, lastSeenLabel)
        
        containerView.edges(to: contentView, insets: .horizontal(16.0) + .vertical(8.0))
        
        usernameLabel.edges(to: containerView, excluding: .bottom, insets: .horizontal(16.0) + .top(16.0))
        
        lastSeenLabel.topToBottom(of: usernameLabel, offset: 8.0)
        lastSeenLabel.edges(to: containerView, excluding: .top, insets: .horizontal(16.0) + .bottom(16.0))
    }
    
}

//MARK: - Configure

extension ChannelParticipantTableViewCell {
    
    func configure(username: String, lastSeen: String) {
        usernameLabel.text = username
        lastSeenLabel.text = "Last seen: " + lastSeen + " minutes ago"
    }
    
}
