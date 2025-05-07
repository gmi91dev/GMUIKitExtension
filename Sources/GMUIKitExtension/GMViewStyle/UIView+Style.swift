//
//  UIView+Style.swift
//  AutoLayoutDemo
//
//  Created by 郑恒 on 2022/10/23.
//

import UIKit

public extension UIView {
    
    // 圆角
    @discardableResult
    func gmRadius(_ length: CGFloat = 8, maskToBounds: Bool = false) -> Self {
        layer.cornerRadius = length
        layer.masksToBounds = maskToBounds
        return self
    }
    
    // 描边
    @discardableResult
    func gmBorder(_ length: CGFloat = 1.0, color: UIColor = .lightGray) -> Self {
        layer.borderWidth = length
        layer.borderColor = color.cgColor
        return self
    }
    
    // 阴影
    @discardableResult
    func gmShadow(_ color: UIColor = .black, offset: CGSize = CGSize(width: 3, height: 3), radius: CGFloat = 1, opacity: Float = 1) -> Self {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        return self
    }
    
    // 设置背景
    @discardableResult
    func gmBackgroundColor(_ color: UIColor? = .white) -> Self {
        backgroundColor = color
        return self
    }
    
    // 添加到(此方法要在布局方法之前调用)
    @discardableResult
    func gmAdd(to targetView: UIView) -> Self {
        targetView.addSubview(self)
        return self
    }
    
    // 透明度
    @discardableResult
    func gmAlpha(_ value: CGFloat) -> Self {
        var tmp: CGFloat = 0.0
        tmp = max(0, value)
        tmp = min(1.0, tmp)
        alpha = tmp
        return self
    }
    
    @discardableResult
    func gmContentMode(_ mode: UIView.ContentMode) -> Self {
        contentMode = .center
        return self
    }
    
    @discardableResult
    func gmHidden(_ value: Bool = true) -> Self {
        isHidden = value
        return self
    }
    
    @discardableResult
    func gmMask(_ view: UIView) -> Self {
        mask = view
        return self
    }
    
    @discardableResult
    func gmEnableUserInteraction(_ value: Bool = true) -> Self {
        isUserInteractionEnabled = value
        return self
    }
    
    // 触摸事件
    @discardableResult
    func gmGesture(_ gesture: UIGestureRecognizer) -> Self {
        addGestureRecognizer(gesture)
        return self
    }
    
    /// 多边形遮罩
    @discardableResult
    func gmPolygon(size: CGFloat, sides: Int = 3, lineWidth: CGFloat = 0, radius: CGFloat = 0, borderColor: UIColor = .purple) -> Self {
        
        guard sides > 2 else { return self }
        
        // 多边形
        let path = UIBezierPath.polygon(in: CGRect(x: 0, y: 0, width: size, height: size), sides: sides, lineWidth: lineWidth, cornerRadius: radius)
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.lineWidth = lineWidth
        mask.strokeColor = UIColor.clear.cgColor
        mask.fillColor = UIColor.white.cgColor
        layer.mask = mask
        
        if lineWidth > 0 {
            let border = CAShapeLayer()
            border.path = path.cgPath
            border.lineWidth = lineWidth
            border.strokeColor = borderColor.cgColor
            border.fillColor = UIColor.clear.cgColor
            layer.addSublayer(border)
        }
        return self
    }
    
}
