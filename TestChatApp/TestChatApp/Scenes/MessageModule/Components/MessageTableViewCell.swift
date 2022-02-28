//
//  MessageTableViewCell.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 26/02/22.
//

import UIKit
import TinyConstraints

class MessageTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue.withAlphaComponent(0.3)
        view.roundCorners(radius: 16.0)
        
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
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
        
        messageLabel.text = nil
    }
    
    //MARK: - Methods
    
    private func layout() {
        contentView.addSubview(containerView)
        containerView.addSubview(messageLabel)
        
        containerView.edges(to: contentView, insets: .horizontal(16.0) + .vertical(8.0))
        messageLabel.edges(to: containerView, insets: .horizontal(16.0) + .vertical(16.0))
    }
    
}

//MARK: - Configure

extension MessageTableViewCell {
    
    func configure(with text: String) {
        messageLabel.text = text
    }
    
}
