//
//  UIButton+Style.swift
//  AutoLayoutDemo
//
//  Created by 郑恒 on 2022/10/24.
//

import UIKit

public struct GMButtonStyle {
    var attributedTitle: NSAttributedString?
    var title: String?
    var titleColor: UIColor?
    var font: UIFont?
    var titleShadowColor: UIColor?
    var image: UIImage?
    var backgroundImage: UIImage?
    var state: UIControl.State
    
    public init(
        attributedTitle: NSAttributedString? = nil,
        title: String? = nil,
        titleColor: UIColor? = nil,
        font: UIFont? = nil,
        titleShadowColor: UIColor? = nil,
        image: UIImage? = nil,
        backgroundImage: UIImage? = nil,
        state: UIControl.State
    ) {
        self.attributedTitle = attributedTitle
        self.title = title
        self.titleColor = titleColor
        self.font = font
        self.titleShadowColor = titleShadowColor
        self.image = image
        self.backgroundImage = backgroundImage
        self.state = state
    }
    
}

public extension UIButton {
    
    // 设置 button style
    @discardableResult
    func gmButtonStyle(_ buttonStyles: GMButtonStyle...) -> Self {
        
        for s in buttonStyles {
            if let img = s.image {
                setImage(img, for: s.state)
            }
            if let attTitle = s.attributedTitle {
                setAttributedTitle(attTitle, for: s.state)
            }else if let title = s.title {
                setTitle(title, for: s.state)
            }
            if let titleColor = s.titleColor {
                setTitleColor(titleColor, for: s.state)
            }
            
            if let font = s.font {
                titleLabel?.font = font
            }
            
            if let titleShadow = s.titleShadowColor {
                setTitleShadowColor(titleShadow, for: s.state)
            }
            if let bgImg = s.backgroundImage {
                setBackgroundImage(bgImg, for: s.state)
            }
            
        }
        return self
    }
    
    // 按钮点击
    @discardableResult
    func gmOnTap(_ target: Any?, for event: UIControl.Event, action: Selector) -> Self {
        addTarget(target, action: action, for: event)
        return self
    }
    
    // 触摸事件
//    @discardableResult
//    func gmGesture(_ gesture: UIGestureRecognizer) -> Self {
//        addGestureRecognizer(gesture)
//        return self
//    }
    
}
