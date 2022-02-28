//
//  UserTableViewCell.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 27/02/22.
//

import UIKit
import TinyConstraints

class UserTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17.0, weight: .semibold)
        
        return label
    }()
    
    private let selectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
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
        selectionImageView.image = nil
    }
    
    private func layout() {
        contentView.addSubviews(usernameLabel, selectionImageView)
        
        usernameLabel.edges(to: contentView, excluding: .right, insets: .left(16.0) + .vertical(8.0))
        
        selectionImageView.leftToRight(of: usernameLabel, offset: 16.0, relation: .equalOrGreater)
        selectionImageView.top(to: contentView, offset: 8.0, relation: .equalOrGreater)
        selectionImageView.bottom(to: contentView, offset: -8.0, relation: .equalOrLess)
        selectionImageView.centerY(to: contentView)
        selectionImageView.right(to: contentView, offset: -16.0)
    }
    
}

extension UserTableViewCell {
    
    func configure(with user: UserViewModel) {
        usernameLabel.text = user.nickname ?? user.id
        let image = user.isSelected ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "plus.circle")
        selectionImageView.image = image
    }
    
}
