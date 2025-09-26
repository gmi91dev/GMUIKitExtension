//
//  GMGradientButton.swift
//  AutoLayoutDemo
//
//  Created by 郑恒 on 2022/10/24.
//

import UIKit

public class GMGradientButton: UIButton {
    
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        layer.insertSublayer(l, at: 0)
        return l
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = layer.bounds
    }
    
    /* 渐变起始和结束位置point值坐标解释
     (0, 0)|--------|(1, 0)
     |        |
     |        |
     (0, 1)|--------|(1, 1)
     */
    // 设置渐变layer，只有GMGradientView有此方法
    @discardableResult
    public func gmGradient(_ colors: [UIColor] = [.black, .white], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1), gradientType: CAGradientLayerType = .axial, cornerRadius: CGFloat? = nil, maskedCorners: GMGradientMaskCorners = .all) -> Self {
        
        gradientLayer.colors = colors.map({$0.cgColor})
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        if let radius = cornerRadius {
            gradientLayer.cornerRadius = radius
            gradientLayer.maskedCorners = maskedCorners.corners
        }
        
        return self
    }
    
}


