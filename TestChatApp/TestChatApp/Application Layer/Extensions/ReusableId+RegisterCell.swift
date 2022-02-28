//
//  ReusableId+RegisterCell.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 26/02/22.
//

import UIKit

public protocol Reusable {
   
   static var reusableId: String { get }
   
}

extension UITableViewCell: Reusable {
   
   public static var reusableId: String { String(describing: self) }
   
}

public extension UITableView {
   
   func register<T: UITableViewCell>(_ :T.Type) {
      register(T.self, forCellReuseIdentifier: T.reusableId)
   }

   func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
      guard let cell = dequeueReusableCell(withIdentifier: T.reusableId, for: indexPath) as? T else {
         fatalError("Could not dequeue cell with identifier: \(T.reusableId)")
      }

      return cell
    }
   
}

