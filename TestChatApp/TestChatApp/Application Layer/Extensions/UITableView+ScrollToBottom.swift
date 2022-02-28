//
//  UITableView+ScrollToBottom.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 28/02/22.
//

import UIKit.UITableView

extension UITableView {
    
    func scrollToBottom(animated: Bool) {
        guard numberOfSections > 0 else { return }
        guard numberOfRows(inSection: numberOfSections - 1) > 0 else { return }

        let section = (numberOfSections - 1)
        let row = (numberOfRows(inSection: section) - 1)
        let indexPath = IndexPath(row: row, section: section)
        
        scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
    
}
