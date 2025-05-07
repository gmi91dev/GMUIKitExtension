//
//  UIImageView+Extension.swift
//  Neat and orderly
//
//  Created by gmi91 on 2023/2/16.
//

import UIKit

public extension UIImageView {
    
    @discardableResult
    func gmImage(named name: String) -> Self {
        image = UIImage(named: name)
        return self
    }
    
}
