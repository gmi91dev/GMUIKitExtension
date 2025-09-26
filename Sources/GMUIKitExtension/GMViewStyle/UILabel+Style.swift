//
//  UILabel+Style.swift
//  AutoLayoutDemo
//
//  Created by 郑恒 on 2022/10/24.
//

import UIKit

extension UILabel {
    
    @discardableResult
    public func gmLines(_ lines: Int = 0) -> Self {
        numberOfLines = lines
        return self
    }
    
    @discardableResult
    public func gmText(_ text: String, font: UIFont = .systemFont(ofSize: 16), alignment: NSTextAlignment? = nil) -> Self {
        self.text = text
        self.font = font
        if let al = alignment {
            textAlignment = al
        }
        return self
    }
    
    @discardableResult
    public func gmAttributedText(_ text: String, attributes: [NSAttributedString.Key: Any]?) -> Self {
        attributedText = NSAttributedString(string: text, attributes: attributes)
        return self
    }
    
    @discardableResult
    public func gmForgroundColor(_ color: UIColor? = .black) -> Self {
        textColor = color
        return self
    }
    
}
