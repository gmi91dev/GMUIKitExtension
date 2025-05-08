//
//  SwiftUIView.swift
//  GMUIKitExtension
//
//  Created by gmi91 on 2025/5/8.
//

import UIKit

public extension UISwitch {
    
    @discardableResult
    func gmOnValueChange(_ target: Any?, action: Selector) -> Self {
        addTarget(target, action: action, for: .valueChanged)
        return self
    }
    
    @discardableResult
    func gmSetOn(_ value: Bool, animated: Bool = true) -> Self {
        setOn(value, animated: animated)
        return self
    }
    
}
