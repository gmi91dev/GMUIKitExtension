//
//  UIImageView+Extension.swift
//  Neat and orderly
//
//  Created by gmi91 on 2023/2/16.
//

import UIKit

extension UIImageView {
    
    @discardableResult
    public func gmImage(named name: String) -> Self {
        image = UIImage(named: name)
        return self
    }
    
}
