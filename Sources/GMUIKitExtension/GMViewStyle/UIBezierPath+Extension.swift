//
//  UIBezierPath+Extension.swift
//  WildernessRecord
//
//  Created by gmi91 on 2023/2/24.
//

import UIKit

public enum WRMaskCorners {
    case topLeft(_ value: CGFloat)
    case topRight(_ value: CGFloat)
    case bottomLeft(_ value: CGFloat)
    case bottomRight(_ value: CGFloat)
    case top(_ value: CGFloat)
    case bottom(_ value: CGFloat)
    case left(_ value: CGFloat)
    case right(_ value: CGFloat)
    case all(_ value: CGFloat)
    
    case topLeftMax
    case topRightMax
    case bottomLeftMax
    case bottomRightMax
    case topMax
    case bottomMax
    case leftMax
    case rightMax
    case allMax
}

extension UIBezierPath {
    
    /// 圆角矩形 ( all >> right > left >> bottom >> top >> topLeft, topRight, borromLeft, bottomRight )
    public static func pathForCorners(in rect: CGRect, corners: [WRMaskCorners]) -> UIBezierPath {
        let path = UIBezierPath()
        path.lineJoinStyle = .round

        // 准备工作
        let width: CGFloat = rect.width
        let height: CGFloat = rect.height
        
        var x: CGFloat = rect.origin.x
        var y: CGFloat = rect.origin.y
        var center: CGPoint = .zero
        
        var topLeft: CGFloat = 0.0
        var topRight: CGFloat = 0.0
        var bottomLeft: CGFloat = 0.0
        var bottomRight: CGFloat = 0.0
        
        let delta = min(width, height)
        let maxR = delta * 0.5
        
        for corner in corners {
            switch corner {
            case .topLeft(let value):
                let tmp = min(value, maxR)
                topLeft = tmp
                x = rect.origin.x + tmp
            case .topRight(let value):
                topRight = min(value, maxR)
            case .bottomLeft(let value):
                bottomLeft = min(value, maxR)
            case .bottomRight(let value):
                bottomRight = min(value, maxR)
            case .top(let value):
                let tmp = min(value, maxR)
                topLeft = tmp
                topRight = tmp
                
                x = rect.origin.x + tmp
                
            case .bottom(let value):
                let tmp = min(value, maxR)
                bottomLeft = tmp
                bottomRight = tmp
            case .left(let value):
                let tmp = min(value, maxR)
                topLeft = tmp
                bottomLeft = tmp
                
                x = rect.origin.x + tmp
                
            case .right(let value):
                let tmp = min(value, maxR)
                topRight = tmp
                bottomRight = tmp
            case .all(let value):
                let tmp = min(value, maxR)
                topLeft = tmp
                topRight = tmp
                bottomLeft = tmp
                bottomRight = tmp
                
                x = rect.origin.x + tmp
                
            case .topLeftMax:
                topLeft = maxR
                x = rect.origin.x + maxR
            case .topRightMax:
                topRight = maxR
            case .bottomLeftMax:
                bottomLeft = maxR
            case .bottomRightMax:
                bottomRight = maxR
            case .topMax:
                topLeft = maxR
                topRight = maxR
                x = rect.origin.x + maxR
            case .bottomMax:
                bottomLeft = maxR
                bottomRight = maxR
            case .leftMax:
                topLeft = maxR
                bottomLeft = maxR
                x = rect.origin.x + maxR
            case .rightMax:
                topRight = maxR
                bottomRight = maxR
            case .allMax:
                topLeft = maxR
                topRight = maxR
                bottomRight = maxR
                bottomLeft = maxR
                x = rect.origin.x + maxR
            }
            
        }
        
        /** 绘制路径 */
        // 1.原点
        path.move(to: CGPoint(x: x, y: y))
        
        // 2. 上边
        x += (width - topLeft - topRight)
        path.addLine(to: CGPoint(x: x, y: y))
        
        // 3. 右上圆角
        if topRight > 0 {
            y += topRight
            center = CGPoint(x: x, y: y)
            path.addArc(withCenter: center, radius: topRight, startAngle: 1.5*Double.pi, endAngle: 2.0*Double.pi, clockwise: true)
            x += topRight
        }
        
        // 4. 右边
        y += (height - topRight - bottomRight)
        path.addLine(to: CGPoint(x: x, y: y))
        
        // 5. 右下角圆角
        if bottomRight > 0 {
            x -= bottomRight
            center = CGPoint(x: x, y: y)
            path.addArc(withCenter: center, radius: bottomRight, startAngle: 0, endAngle: 0.5*Double.pi, clockwise: true)
            y += bottomRight
        }
        
        // 6. 下边
        x -= (width-bottomLeft-bottomRight)
        path.addLine(to: CGPoint(x: x, y: y))
        
        // 7. 左下圆角
        if bottomLeft > 0 {
            y -= bottomLeft
            center = CGPoint(x: x, y: y)
            path.addArc(withCenter: center, radius: bottomLeft, startAngle: 0.5*Double.pi, endAngle: Double.pi, clockwise: true)
            x -= bottomLeft
        }
        
        // 8. 左边
        y -= (height - bottomLeft - topLeft)
        path.addLine(to: CGPoint(x: x, y: y))
        
        // 9。 左上圆角
        if topLeft > 0 {
            x += topLeft
            center = CGPoint(x: x, y: y)
            path.addArc(withCenter: center, radius: topLeft, startAngle: Double.pi, endAngle: 1.5*Double.pi, clockwise: true)
        }
        
        // 10. 原点归零
        x = rect.origin.x
        y = rect.origin.y
        
        path.close()
        
        return path
        
    }
    
    /// 绘制正多边形
    public static func polygon(in rect: CGRect, sides: Int, lineWidth: CGFloat, cornerRadius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        let theta = (2.0 * Double.pi) / Double(sides)                       // how much to turn at every corner
        let offset = Float(cornerRadius) * tanf(Float(theta / 2.0))           // offset from which to start rounding corners
        let squareWidth = min(rect.size.width, rect.size.height)      // width of the square
        
        // calculate the length of the sides of the polygon
        
        var length = Float(squareWidth - lineWidth)
        if (sides % 4 != 0) {                                               // if not dealing with polygon which will be square with all sides ...
            length = length * cosf(Float(theta / 2.0)) + offset/2.0               // ... offset it inside a circle inside the square
        }
        let sideLength = length * tanf(Float(theta / 2.0));
        
        // start drawing at `point` in lower right corner
        var x = rect.origin.x + rect.size.width / 2.0 + CGFloat(sideLength) / 2.0 - CGFloat(offset)
        var y = rect.origin.y + rect.size.height / 2.0 + CGFloat(length) / 2.0
        var point = CGPoint(x: x, y: y)
        
        var angle = Double.pi
        
        path.move(to: point)
        
        // draw the sides and rounded corners of the polygon
        
        for _ in 0..<sides {
            x = point.x + CGFloat((sideLength - offset * 2.0) * cosf(Float(angle)))
            y = point.y + CGFloat((sideLength - offset * 2.0) * sinf(Float(angle)))
            point = CGPoint(x: x, y: y)
            path.addLine(to: point)
            
            x = point.x + cornerRadius * CGFloat(cosf(Float(angle + Double.pi/2)))
            y = point.y + cornerRadius * CGFloat(sinf(Float(angle + Double.pi/2)))
            
            let center = CGPoint(x: x, y: y)
            path.addArc(withCenter: center, radius: cornerRadius, startAngle: angle - Double.pi/2, endAngle: Double(angle) + theta - Double.pi/2, clockwise: true)
            
            point = path.currentPoint // we don't have to calculate where the arc ended ... UIBezierPath did that for us
            angle += theta
        }
        path.close()
        
        path.lineWidth = lineWidth // in case we're going to use CoreGraphics to stroke path, rather than CAShapeLayer
        path.lineJoinStyle = .round
        
        return path
    }
    
}

