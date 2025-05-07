//
//  UIView+GMLayoutBase.swift
//  AutoLayoutDemo
//
//  Created by 郑恒 on 2022/10/23.
//

import UIKit

public extension UIView {
    var width: CGFloat {frame.width}
    var height: CGFloat {frame.height}
    var bottom: CGFloat {frame.maxY}
    var right: CGFloat {frame.maxX}
    var x: CGFloat {frame.origin.x}
    var y: CGFloat {frame.origin.y}
    var centerX: CGFloat {center.x}
    var centerY: CGFloat {center.y}
    var size: CGSize {frame.size}
}
