//
//  AddTargets.swift
//  TestChatApp
//
//  Created by Majit Uteniyazov on 23/02/22.
//

import UIKit

/// Closurable protocol
public protocol Closurable: AnyObject {}
// restrict protocol to only classes => can refer to the class instance in the protocol extension
public extension Closurable {
  // Create container for closure, store it and return it
    func getContainer(for closure: @escaping (Self) -> Void) -> ClosureContainer<Self> {
        weak var weakSelf = self
        let container = ClosureContainer(closure: closure, caller: weakSelf)
        // store the container so that it can be called later, we do not need to explicitly retrieve it.
        objc_setAssociatedObject(self, Unmanaged.passUnretained(self).toOpaque(), container as AnyObject?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        return container
    }
}

/// Container class for closures, so that closure can be stored as an associated object
public final class ClosureContainer<T: Closurable> {
    var closure: (T) -> Void
    var caller: T?

    public init(closure: @escaping (T) -> Void, caller: T?) {
        self.closure = closure
        self.caller = caller
    }

    // method for the target action, visible to UIKit classes via @objc
    @objc public func processHandler() {
        if let caller = caller {
            closure(caller)
        }
    }

    // target action
    public var action: Selector { #selector(processHandler) }
}

// ************** UIKit extensions ***************
/// extension for UIButton - actions with closure
extension UIButton: Closurable {
    public func addTarget(for event: UIControl.Event = .touchUpInside, closure: @escaping (UIButton) -> ()) {
        let container = getContainer(for: closure)
        addTarget(container, action: container.action, for: event)
    }
}

extension UITextField: Closurable {
    public func addTarget(for event: UIControl.Event = .editingChanged, closure: @escaping (UITextField) -> ()) {
        let container = getContainer(for: closure)
        addTarget(container, action: container.action, for: event)
    }
}

/// extension for UIGestureRecognizer - actions with closure
extension UIGestureRecognizer: Closurable {
    public convenience init(closure: @escaping (UIGestureRecognizer) -> Void) {
        self.init()

        let container = getContainer(for: closure)
        addTarget(container, action: container.action)
    }
}

extension UISwipeGestureRecognizer {
    public convenience init(direction: UISwipeGestureRecognizer.Direction, _ closure: @escaping (UISwipeGestureRecognizer) -> Void) {
        self.init()
        
        self.direction = direction
        let container = getContainer(for: closure)
        addTarget(container, action: container.action)
    }
}

/// extension for UIBarButtonItem - actions with closure
extension UIBarButtonItem: Closurable {
    public convenience init(image: UIImage?, style: UIBarButtonItem.Style = .plain, closure: @escaping (UIBarButtonItem) -> Void) {
        self.init(image: image, style: style, target: nil, action: nil)

        let container = getContainer(for: closure)
        target = container
        action = container.action
    }

    public convenience init(title: String?, style: UIBarButtonItem.Style = .plain, closure: @escaping (UIBarButtonItem) -> Void) {
        self.init(title: title, style: style, target: nil, action: nil)

        let container = getContainer(for: closure)
        target = container
        action = container.action
    }
    
    public convenience init(_ item: SystemItem, closure: @escaping (UIBarButtonItem) -> Void) {
        self.init(barButtonSystemItem: item, target: nil, action: nil)
        
        let container = getContainer(for: closure)
        target = container
        action = container.action
    }
}
