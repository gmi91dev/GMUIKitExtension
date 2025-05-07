//
//  GMView.swift
//  AutoLayoutDemo
//
//  Created by 郑恒 on 2022/10/24.
//

import UIKit

public enum GMGradientMaskCorners: String, CaseIterable {
    case leftTop, leftBottom, rightTop, rightBottom,
         left, right, top, bottom,
         excludeLeftTop, excludeLeftBottom, excludeRightTop, excludeRightBottom, all
    
    var corners: CACornerMask {
        switch self {
        case .leftTop:
            return [.layerMinXMinYCorner]
        case .leftBottom:
            return [.layerMinXMaxYCorner]
        case .rightTop:
            return [.layerMaxXMinYCorner]
        case .rightBottom:
            return [.layerMaxXMaxYCorner]
        case .left:
            return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case .right:
            return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .top:
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom:
            return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .excludeLeftTop:
            return [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .excludeLeftBottom:
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .excludeRightTop:
            return [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .excludeRightBottom:
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        case .all:
            return [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
}

public class GMGradientView: UIView {

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
    func gmGradient(_ colors: [UIColor] = [.black, .white], startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 1), gradientType: CAGradientLayerType = .axial, cornerRadius: CGFloat? = nil, maskedCorners: GMGradientMaskCorners = .all) -> Self {
        
        gradientLayer.colors = colors.map({$0.cgColor})
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.masksToBounds = true
        
        if let radius = cornerRadius {
            gradientLayer.cornerRadius = radius
            gradientLayer.maskedCorners = maskedCorners.corners
        }
        
        return self
    }
    
}
