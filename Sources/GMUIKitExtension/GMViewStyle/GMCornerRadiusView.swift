//
//  GMCornerRadiusView.swift
//  WildernessRecord
//
//  Created by gmi91 on 2023/2/24.
//

import UIKit
import CoreGraphics

public class GMCornerRadiusView: UIView {
    
    public var borderColor: UIColor = .red
    public var borderWidth: CGFloat = 2.0
    
    private lazy var maskLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.clear.cgColor
        layer.fillColor = UIColor.white.cgColor
        return layer
    }()
    
    private lazy var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layer)
        return layer
    }()
    
    private var corners = [WRMaskCorners]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.mask = maskLayer
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.mask = maskLayer
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateMask()
    }
    
    private func updateMask() {
        guard corners.count > 0 else { return }
        let path = UIBezierPath.pathForCorners(in: bounds, corners: corners)
        maskLayer.path = path.cgPath
        
        if borderWidth > 0 {
            borderLayer.isHidden = false
            borderLayer.path = path.cgPath
            borderLayer.lineWidth = borderWidth
            borderLayer.strokeColor = borderColor.cgColor
        }else {
            borderLayer.isHidden = true
        }
    }
    
    @discardableResult
    public func gmRadius(_ corners: WRMaskCorners..., borderWidth: CGFloat = 0.0, borderColor: UIColor = .red) -> Self {
        self.corners = Array(corners)
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        return self
    }
    
}
