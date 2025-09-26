//
//  GMLayout.swift
//  AutoLayoutDemo
//
//  Created by 郑恒 on 2022/10/23.
//

import UIKit

public enum GMAspectRatio {
    case widthToHeight, heightToWidth
}

public enum GMLayoutRelation {
    case equal, lessOrEqualThan, greaterOrEqualThan
}

private enum GMLayoutXAttribute {
    case left(_ constant: CGFloat = 0.0)
    case right(_ constant: CGFloat = 0.0)
    case centerX(_ constant: CGFloat = 0.0)
    case leading(_ constant: CGFloat = 0.0)
    case trailing(_ constant: CGFloat = 0.0)
}

private enum GMLayoutYAttribute {
    case top(_ constant: CGFloat = 0.0)
    case bottom(_ constant: CGFloat = 0.0)
    case centerY(_ constant: CGFloat = 0.0)
    case firstBaseline(_ constant: CGFloat = 0.0)
    case lastBaseline(_ constant: CGFloat = 0.0)
}

private enum GMLayoutDimensionAttribute {
    case width(_ constant: CGFloat = 0.0, _ multiplier: CGFloat = 1.0)
    case height(_ constant: CGFloat = 0.0, _ multiplier: CGFloat = 1.0)
}

extension UIView {
    
    // 平铺
    @discardableResult
    public func gmFull(ignoreSafeArea: Bool = true) -> Self {
        return gmPadding(0, ignoreSafeArea: ignoreSafeArea)
    }
        
    @discardableResult
    public func gmCenter(x: CGFloat = 0.0, y: CGFloat = 0.0, to targetView: UIView? = nil, complete: ((_ x: NSLayoutConstraint, _ y: NSLayoutConstraint)->Void)? = nil) -> Self {
        
        var tmpView = targetView
        if tmpView == nil {
            tmpView = superview
        }
        guard let view = tmpView else {return self}
        
        if let xConstraint = add(attribute: .centerX(x), to: view.centerXAnchor), let yConstraint = add(attribute: .centerY(y), to: view.centerYAnchor) {
            complete?(xConstraint, yConstraint)
        }
        
        return self
    }
    
    /// 自动布局之前必须先调用本方法
    private func gmStartLayout() {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}

// MARK: - Padding
extension UIView {
    
    @discardableResult
    public func gmPadding(_ value: CGFloat = 8.0, on view: UIView? = nil, ignoreSafeArea: Bool = true, useaLeading: Bool = false, complete: ((_ left: NSLayoutConstraint, _ top: NSLayoutConstraint, _ right: NSLayoutConstraint, _ bottom: NSLayoutConstraint)->Void)? = nil) -> Self {
        if useaLeading {
            return gmPadding(left: value, top: value, right: value, bottom: value, on: view, ignoreSafeArea: ignoreSafeArea, complete: complete)
        }else {
            return gmPadding(leading: value, top: value, trailing: value, bottom: value, on: view, ignoreSafeArea: ignoreSafeArea, complete: complete)
        }
    }
    
    @discardableResult
    public func gmPadding(left leftConstant: CGFloat, top topConstant: CGFloat, right rightConstant: CGFloat, bottom bottomConstant: CGFloat, on targetView: UIView? = nil, ignoreSafeArea: Bool = true, complete: ((_ left: NSLayoutConstraint, _ top: NSLayoutConstraint, _ right: NSLayoutConstraint, _ bottom: NSLayoutConstraint)->Void)? = nil) -> Self {
                
        var tmpView = targetView
        if tmpView == nil {
            tmpView = superview
        }
        guard let view = tmpView else {return self}
        
        if let leftConstraint = add(attribute: .left(leftConstant), to: ignoreSafeArea ? view.leftAnchor : view.safeAreaLayoutGuide.leftAnchor),
           let topConstraint = add(attribute: .top(topConstant), to: ignoreSafeArea ? view.topAnchor : view.safeAreaLayoutGuide.topAnchor),
            let rightConstraint = add(attribute: .right(rightConstant), to: ignoreSafeArea ? view.rightAnchor : view.safeAreaLayoutGuide.rightAnchor),
            let bottomContraint = add(attribute: .bottom(bottomConstant), to: ignoreSafeArea ? view.bottomAnchor : view.safeAreaLayoutGuide.bottomAnchor) {
            complete?(leftConstraint, topConstraint, rightConstraint, bottomContraint)
        }
        return self
    }
    
    @discardableResult
    public func gmPadding(leading leadingConstant: CGFloat, top topConstant: CGFloat, trailing trailingConstant: CGFloat, bottom bottomConstant: CGFloat, on targetView: UIView? = nil, ignoreSafeArea: Bool = true, complete: ((_ leading: NSLayoutConstraint, _ top: NSLayoutConstraint, _ trailing: NSLayoutConstraint, _ bottom: NSLayoutConstraint)->Void)? = nil) -> Self {
                
        var tmpView = targetView
        if tmpView == nil {
            tmpView = superview
        }
        guard let view = tmpView else {return self}
        
        if let leadingConstraint = add(attribute: .leading(leadingConstant), to: ignoreSafeArea ? view.leadingAnchor : view.safeAreaLayoutGuide.leadingAnchor),
           let topConstraint = add(attribute: .top(topConstant), to: ignoreSafeArea ? view.topAnchor : view.safeAreaLayoutGuide.topAnchor),
            let trailingConstraint = add(attribute: .trailing(trailingConstant), to: ignoreSafeArea ? view.trailingAnchor : view.safeAreaLayoutGuide.trailingAnchor),
            let bottomContraint = add(attribute: .bottom(bottomConstant), to: ignoreSafeArea ? view.bottomAnchor : view.safeAreaLayoutGuide.bottomAnchor) {
            complete?(leadingConstraint, topConstraint, trailingConstraint, bottomContraint)
        }
        return self
    }
}

// MARK: - Horizontal layout
extension UIView {
    
    @discardableResult
    public func gmHorizontal(_ value: CGFloat = 0.0, on targetView: UIView? = nil, ignoreSafeArea: Bool = true, useLeading: Bool = false, complete: ((_ left: NSLayoutConstraint, _ right: NSLayoutConstraint)->Void)? = nil) -> Self {
        
        if useLeading {
            return gmHorizontal(leading: value, trailing: value, on: targetView, ignoreSafeArea: ignoreSafeArea, complete: complete)
        }else {
            return gmHorizontal(left: value, right: value, on: targetView, ignoreSafeArea: ignoreSafeArea, complete: complete)
        }
    }
        
    @discardableResult
    public func gmHorizontal(left leftConstant: CGFloat, right rightConstant: CGFloat, on targetView: UIView? = nil, ignoreSafeArea: Bool = true, complete: ((_ left: NSLayoutConstraint, _ right: NSLayoutConstraint)->Void)? = nil) -> Self {
                
        var tmpView = targetView
        if tmpView == nil {
            tmpView = superview
        }
        guard let view = tmpView else {return self}
        
        if let leftConstraint = add(attribute: .left(leftConstant), to: ignoreSafeArea ? view.leftAnchor : view.safeAreaLayoutGuide.leftAnchor), let rightConstraint = add(attribute: .right(rightConstant), to: ignoreSafeArea ? view.rightAnchor : view.safeAreaLayoutGuide.rightAnchor) {
            complete?(leftConstraint, rightConstraint)
        }
        
        return self
    }
    
    @discardableResult
    public func gmHorizontal(leading leadingConstant: CGFloat, trailing trailingConstant: CGFloat, on targetView: UIView? = nil, ignoreSafeArea: Bool = true, complete: ((_ leading: NSLayoutConstraint, _ trailing: NSLayoutConstraint)->Void)? = nil) -> Self {
                
        var tmpView = targetView
        if tmpView == nil {
            tmpView = superview
        }
        guard let view = tmpView else {return self}
        
        if let leadingConstraint = add(attribute: .leading(leadingConstant), to: ignoreSafeArea ? view.leadingAnchor : view.safeAreaLayoutGuide.leadingAnchor), let trailingConstraint = add(attribute: .trailing(trailingConstant), to: ignoreSafeArea ? view.trailingAnchor : view.safeAreaLayoutGuide.trailingAnchor) {
            complete?(leadingConstraint, trailingConstraint)
        }
        return self
    }
    
    // MARK: - Base horizontal layout
    
    // left
    @discardableResult
    public func gmLeft(_ constant: CGFloat = 0.0, _ relation: GMLayoutRelation = .equal, to layoutAnchor: NSLayoutXAxisAnchor? = nil, ignoreSafeArea: Bool = true, complete: ((NSLayoutConstraint)->Void)? = nil) -> Self {
        if let targetAnchor = layoutAnchor {
            if let constraint = add(attribute: .left(constant), relation: relation, to: targetAnchor) {
                complete?(constraint)
            }
            return self
        }
        
        guard let supView = superview else {return self}
        if let constraint = add(attribute: .left(constant), relation: relation, to: ignoreSafeArea ? supView.leftAnchor : supView.safeAreaLayoutGuide.leftAnchor) {
            complete?(constraint)
        }
        return self
        
    }
    
    // right
    @discardableResult
    public func gmRight(_ constant: CGFloat = 0.0, _ relation: GMLayoutRelation = .equal, to layoutAnchor: NSLayoutXAxisAnchor? = nil, ignoreSafeArea: Bool = true, complete: ((NSLayoutConstraint)->Void)? = nil) -> Self {
        if let targetAnchor = layoutAnchor {
            if let constraint = add(attribute: .right(constant), relation: relation, to: targetAnchor) {
                complete?(constraint)
            }
            return self
        }
        
        guard let supView = superview else {return self}
        if let constraint = add(attribute: .right(constant), relation: relation, to: ignoreSafeArea ? supView.rightAnchor : supView.safeAreaLayoutGuide.rightAnchor) {
            complete?(constraint)
        }
        return self
    }
    
    // center x
    @discardableResult
    public func gmCenterX(_ constant: CGFloat = 0.0, _ relation: GMLayoutRelation = .equal, to layoutAnchor: NSLayoutXAxisAnchor? = nil, complete: ((NSLayoutConstraint)->Void)? = nil) -> Self {
        
        if let targetAnchor = layoutAnchor {
            if let constraint = add(attribute: .centerX(constant), relation: relation, to: targetAnchor) {
                complete?(constraint)
            }
            return self
        }
        
        guard let supView = superview else {return self}
        
        if let constraint = add(attribute: .centerX(constant), relation: relation, to: supView.centerXAnchor) {
            complete?(constraint)
        }
        
        return self
    }
    
    // leading
    @discardableResult
    public func gmLeading(_ constant: CGFloat = 0.0, _ relation: GMLayoutRelation = .equal, to layoutAnchor: NSLayoutXAxisAnchor? = nil, ignoreSafeArea: Bool = true, complete: ((NSLayoutConstraint)->Void)? = nil) -> Self {
        
        if let targetAnchor = layoutAnchor {
            if let constraint = add(attribute: .leading(constant), relation: relation, to: targetAnchor) {
                complete?(constraint)
            }
            return self
        }
        
        guard let supView = superview else {return self}
        
        if let constraint = add(attribute: .leading(constant), relation: relation, to: ignoreSafeArea ? supView.leadingAnchor : supView.safeAreaLayoutGuide.leadingAnchor) {
            complete?(constraint)
        }
        
        return self
    }
    
    // trailing
    @discardableResult
    public func gmTrailing(_ constant: CGFloat = 0.0, _ relation: GMLayoutRelation = .equal, to layoutAnchor: NSLayoutXAxisAnchor? = nil, ignoreSafeArea: Bool = true, complete: ((NSLayoutConstraint)->Void)? = nil) -> Self {
        if let targetAnchor = layoutAnchor {
            if let constraint = add(attribute: .trailing(constant), relation: relation, to: targetAnchor) {
                complete?(constraint)
            }
            return self
        }
        
        guard let supView = superview else {return self}
        
        if let constraint = add(attribute: .trailing(constant), relation: relation, to: ignoreSafeArea ? supView.trailingAnchor : supView.safeAreaLayoutGuide.trailingAnchor) {
            complete?(constraint)
        }
        
        return self
    }
    
    /// horizontal layout
    @discardableResult
    fileprivate func add(attribute: GMLayoutXAttribute, relation: GMLayoutRelation = .equal, to targetAnchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint? {
        
        gmStartLayout()
        
        var tmpAnchor: NSLayoutXAxisAnchor?
        var constant: CGFloat = 0.0
        
        switch attribute {
        case .left(let value):
            tmpAnchor = leftAnchor
            constant = value
        case .right(let value):
            tmpAnchor = rightAnchor
            constant = -value
        case .centerX(let value):
            tmpAnchor = centerXAnchor
            constant = value
        case .leading(let value):
            tmpAnchor = leadingAnchor
            constant = value
        case .trailing(let value):
            tmpAnchor = trailingAnchor
            constant = -value
        }
        
        guard let anchor = tmpAnchor else { return nil }
        
        var tmpConstraint: NSLayoutConstraint?
        
        var tmpRelation = relation
        
        if constant < 0 {
            switch relation {
            case .lessOrEqualThan:
                tmpRelation = .greaterOrEqualThan
            case .greaterOrEqualThan:
                tmpRelation = .lessOrEqualThan
            default:
                break
            }
        }
        
        switch tmpRelation {
        case .equal:
            tmpConstraint = anchor.constraint(equalTo: targetAnchor, constant: constant)
        case .lessOrEqualThan:
            tmpConstraint = anchor.constraint(lessThanOrEqualTo: targetAnchor, constant: constant)
        case .greaterOrEqualThan:
            tmpConstraint = anchor.constraint(greaterThanOrEqualTo: targetAnchor, constant: constant)
        }
        
        tmpConstraint?.isActive = true
        
        return tmpConstraint
    }
    
}

// MARK: - Vertical layout
extension UIView {
    
    @discardableResult
    public func gmVertical(_ value: CGFloat = 0.0, on targetView: UIView? = nil, ignoreSafeArea: Bool = true, complete: ((_ top: NSLayoutConstraint, _ bottom: NSLayoutConstraint)->Void)? = nil) -> Self {
                
        var tmpView = targetView
        if tmpView == nil {
            tmpView = superview
        }
        guard let view = tmpView else {return self}
        
        if let topConstraint = add(attribute: .top(value), to: ignoreSafeArea ? view.topAnchor : view.safeAreaLayoutGuide.topAnchor), let bottomContraint = add(attribute: .bottom(value), to: ignoreSafeArea ? view.bottomAnchor : view.safeAreaLayoutGuide.bottomAnchor) {
            complete?(topConstraint, bottomContraint)
        }
        return self
    }
    
    @discardableResult
    public func gmVertical(top topConstant: CGFloat, bottom bottomConstant: CGFloat, on targetView: UIView? = nil, ignoreSafeArea: Bool = true, complete: ((_ top: NSLayoutConstraint, _ bottom: NSLayoutConstraint)->Void)? = nil) -> Self {
                
        var tmpView = targetView
        if tmpView == nil {
            tmpView = superview
        }
        guard let view = tmpView else {return self}
        
        if let topConstraint = add(attribute: .top(topConstant), to: ignoreSafeArea ? view.topAnchor : view.safeAreaLayoutGuide.topAnchor), let bottomContraint = add(attribute: .bottom(bottomConstant), to: ignoreSafeArea ? view.bottomAnchor : view.safeAreaLayoutGuide.bottomAnchor) {
            complete?(topConstraint, bottomContraint)
        }
        return self
    }
    
    // MARK: - Base vertical layout
    
    @discardableResult
    public func gmTop(_ constant: CGFloat = 0.0, _ relation: GMLayoutRelation = .equal, to layoutAnchor: NSLayoutYAxisAnchor? = nil, ignoreSafeArea: Bool = true, complete: ((NSLayoutConstraint)->Void)? = nil) -> Self {
        if let targetAnchor = layoutAnchor {
            if let constraint = add(attribute: .top(constant), relation: relation, to: targetAnchor) {
                complete?(constraint)
            }
            return self
        }
        
        guard let supView = superview else {return self}
        
        if let constraint = add(attribute: .top(constant), relation: relation, to: ignoreSafeArea ? supView.topAnchor : supView.safeAreaLayoutGuide.topAnchor) {
            complete?(constraint)
        }
        
        return self
    }
    
    @discardableResult
    public func gmBottom(_ constant: CGFloat = 0.0, _ relation: GMLayoutRelation = .equal, to layoutAnchor: NSLayoutYAxisAnchor? = nil, ignoreSafeArea: Bool = true, complete: ((NSLayoutConstraint)->Void)? = nil) -> Self {
        
        if let targetAnchor = layoutAnchor {
            if let constraint = add(attribute: .bottom(constant), relation: relation, to: targetAnchor) {
                complete?(constraint)
            }
            return self
        }
        
        guard let supView = superview else {return self}
              
        if let constraint = add(attribute: .bottom(constant), relation: relation, to: ignoreSafeArea ? supView.bottomAnchor : supView.safeAreaLayoutGuide.bottomAnchor) {
            complete?(constraint)
        }
        
        return self
    }
    
    @discardableResult
    public func gmCenterY(_ constant: CGFloat = 0.0, _ relation: GMLayoutRelation = .equal, to layoutAnchor: NSLayoutYAxisAnchor? = nil, complete: ((NSLayoutConstraint)->Void)? = nil) -> Self {
        
        if let targetAnchor = layoutAnchor {
            if let constraint = add(attribute: .centerY(constant), relation: relation, to: targetAnchor) {
                complete?(constraint)
            }
            return self
        }
        
        guard let supView = superview else {return self}
        
        if let constraint = add(attribute: .centerY(constant), relation: relation, to: supView.centerYAnchor) {
            complete?(constraint)
        }
        return self
    }
    
    /// vertical layout
    @discardableResult
    fileprivate func add(attribute: GMLayoutYAttribute, relation: GMLayoutRelation = .equal, to targetAnchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint? {
        
        gmStartLayout()
        
        var tmpAnchor: NSLayoutYAxisAnchor?
        var constant: CGFloat = 0.0
        
        switch attribute {
        case .top(let value):
            tmpAnchor = topAnchor
            constant = value
        case .bottom(let value):
            tmpAnchor = bottomAnchor
            constant = -value
        case .centerY(let value):
            tmpAnchor = centerYAnchor
            constant = value
        case .firstBaseline(let value):
            tmpAnchor = firstBaselineAnchor
            constant = value
        case .lastBaseline(let value):
            tmpAnchor = lastBaselineAnchor
            constant = value
        }
        
        guard let anchor = tmpAnchor else { return nil }
        
        var tmpConstraint: NSLayoutConstraint?
        
        var tmpRelation = relation
        
        if constant < 0 {
            switch relation {
            case .lessOrEqualThan:
                tmpRelation = .greaterOrEqualThan
            case .greaterOrEqualThan:
                tmpRelation = .lessOrEqualThan
            default:
                break
            }
        }
        
        switch tmpRelation {
        case .equal:
            tmpConstraint = anchor.constraint(equalTo: targetAnchor, constant: constant)
        case .lessOrEqualThan:
            tmpConstraint = anchor.constraint(lessThanOrEqualTo: targetAnchor, constant: constant)
        case .greaterOrEqualThan:
            tmpConstraint = anchor.constraint(greaterThanOrEqualTo: targetAnchor, constant: constant)
        }
        
        tmpConstraint?.isActive = true
        
        return tmpConstraint
    }
}

// MARK - Dimesion layout
extension UIView {

    @discardableResult
    public func gmAspectRatio(_ ratio: GMAspectRatio = .widthToHeight, constant: CGFloat = 0.0, _ relation: GMLayoutRelation = .equal, multiplier: CGFloat = 1.0, complete: ((NSLayoutConstraint)->Void)? = nil) -> Self {
        
        gmStartLayout()
        
        let anchor: NSLayoutDimension = ratio == .widthToHeight ? widthAnchor : heightAnchor
        let targetAnchor: NSLayoutDimension = ratio == .widthToHeight ? heightAnchor : widthAnchor
        var tmpConstraint: NSLayoutConstraint?
        switch relation {
        case .equal:
            tmpConstraint = anchor.constraint(equalTo: targetAnchor, multiplier: multiplier)
        case .lessOrEqualThan:
            tmpConstraint = anchor.constraint(lessThanOrEqualTo: targetAnchor, multiplier: multiplier)
        case .greaterOrEqualThan:
            tmpConstraint = anchor.constraint(greaterThanOrEqualTo: targetAnchor, multiplier: multiplier)
        }
        
        tmpConstraint?.isActive = true
        
        if let constraint = tmpConstraint {
            complete?(constraint)
        }
        
        return self
    }
    
    @discardableResult
    public func gmSize(_ squareConstant: CGFloat = 30, complete: ((_ witdh: NSLayoutConstraint, _ height: NSLayoutConstraint)->Void)? = nil) -> Self {
        return gmSize(width: squareConstant, height: squareConstant, complete: complete)
    }
    
    @discardableResult
    public func gmSize(width: CGFloat, height: CGFloat, _ relation: GMLayoutRelation = .equal, complete: ((_ witdh: NSLayoutConstraint, _ height: NSLayoutConstraint)->Void)? = nil) -> Self {

        if let width = add(attribute: .width(width, 1.0), relation: relation),
            let height = add(attribute: .height(height, 1.0), relation: relation) {
            complete?(width, height)
        }
        return self
    }
    
    @discardableResult
    public func gmWidth(_ constant: CGFloat = 0.0, _ relation: GMLayoutRelation = .equal, multiplier: CGFloat = 1.0, to layoutAnchor: NSLayoutDimension? = nil, complete: ((NSLayoutConstraint)->Void)? = nil) -> Self {
        if let constraint = add(attribute: .width(constant, multiplier), relation: relation, to: layoutAnchor) {
            complete?(constraint)
        }
        return self
    }
    
    @discardableResult
    public func gmHeight(_ constant: CGFloat = 0.0, _ relation: GMLayoutRelation = .equal, multiplier: CGFloat = 1.0, to layoutAnchor: NSLayoutDimension? = nil, complete: ((NSLayoutConstraint)->Void)? = nil) -> Self {
        if let constraint = add(attribute: .height(constant, multiplier), relation: relation, to: layoutAnchor) {
            complete?(constraint)
        }
        return self
    }
    
    @discardableResult
    fileprivate func add(attribute: GMLayoutDimensionAttribute, relation: GMLayoutRelation = .equal, to targetAnchor: NSLayoutDimension? = nil) -> NSLayoutConstraint? {
        
        gmStartLayout()
        
        var tmpAnchor: NSLayoutDimension?
        var constant: CGFloat = 0.0
        var multiplier: CGFloat = 0.0
        
        switch attribute {
        case .width(let value, let mul):
            tmpAnchor = widthAnchor
            constant = value
            multiplier = mul
        case .height(let value, let mul):
            tmpAnchor = heightAnchor
            constant = value
            multiplier = mul
        }
        
        guard let anchor = tmpAnchor else { return nil }
        
        var tmpConstraint: NSLayoutConstraint?
        
        switch relation {
        case .equal:
            if let tar = targetAnchor {
                tmpConstraint = anchor.constraint(equalTo: tar, multiplier: multiplier, constant: constant)
            }else {
                tmpConstraint = anchor.constraint(equalToConstant: constant)
            }
        case .lessOrEqualThan:
            if let tar = targetAnchor {
                tmpConstraint = anchor.constraint(lessThanOrEqualTo: tar, multiplier: multiplier, constant: constant)
            }else {
                tmpConstraint = anchor.constraint(lessThanOrEqualToConstant: constant)
            }
        case .greaterOrEqualThan:
            if let tar = targetAnchor {
                tmpConstraint = anchor.constraint(greaterThanOrEqualTo: tar, multiplier: multiplier, constant: constant)
            }else {
                tmpConstraint = anchor.constraint(greaterThanOrEqualToConstant: constant)
            }
        }
        
        tmpConstraint?.isActive = true
        
        return tmpConstraint
    }
    
}
