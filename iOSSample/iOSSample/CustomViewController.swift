//
//  CustomViewController.swift
//  iOSSample
//
//  Created by gmi91 on 2025/5/2.
//

import UIKit
import GMUIKitExtension

class CustomViewController: UIViewController {

    private var widthConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    private var label = UILabel()
    private var sw = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let rect = UIView()
            .gmSize(100, complete: { witdh, height in
                self.widthConstraint = witdh
                self.heightConstraint = height
            })
            .gmRadius(20)
            .gmBackgroundColor(.random)
            .gmAdd(to: view)
            .gmCenterX()
            .gmTop(20, ignoreSafeArea: false)
        
        GMCornerRadiusView()
            .gmSize(200)
            .gmBackgroundColor(.random)
            .gmRadius(
                .topLeft(10),
                .bottomRight(50),
                borderWidth: 10,
                borderColor: .orange
            )
            .gmAdd(to: view)
            .gmCenterX()
            .gmTop(20, .greaterOrEqualThan, to: rect.bottomAnchor)
        
        let btn = UIButton()
            .gmButtonStyle(
                GMButtonStyle(
                    title: "Change",
                    titleColor: .white,
                    font: .systemFont(ofSize: 18),
                    state: .normal
                )
            )
            .gmBackgroundColor(.blue)
            .gmOnTap(self, for: .touchDown, action: #selector(didClicked))
            .gmAdd(to: view)
            .gmRadius(16)
            .gmHeight(50)
            .gmHorizontal(30)
            .gmBottom(20, ignoreSafeArea: false)
        
        
        sw.gmSetOn(true)
            .gmOnValueChange(self, action: #selector(valueChanged))
            .gmAdd(to: view)
            .gmBottom(10, to: btn.topAnchor)
            .gmRight(0, to: btn.rightAnchor)
        
        label
            .gmText("Spring", font: .systemFont(ofSize: 16), alignment: .center)
            .gmBackgroundColor(.purple)
            .gmForgroundColor(.white)
            .gmLines(1)
            .gmAdd(to: view)
            .gmSize(width: 70, height: 30)
            .gmRadius(10, maskToBounds: true)
            .gmRight(10, to: sw.leftAnchor)
            .gmCenterY(to: sw.centerYAnchor)
        
    }
    
    @objc
    private func valueChanged(_ sender: UISwitch) {
        label.text = sender.isOn ? "Spring" : "Linear"
    }
    
    
    @objc
    private func didClicked(_ sender: Any) {
        if sw.isOn {
            spring()
        }else {
            linear()
        }
    }
    
    private func spring() {
        UIView
            .animate(
                withDuration: 1.32,
                delay: 0.1,
                usingSpringWithDamping: 0.3,
                initialSpringVelocity: 5) {
                    if self.widthConstraint?.constant == 200 {
                        self.widthConstraint?.constant = 100
                        self.heightConstraint?.constant = 100
                    }else {
                        self.widthConstraint?.constant = 200
                        self.heightConstraint?.constant = 200
                    }
                    self.view.layoutIfNeeded()
                }
    }
    
    private func linear() {
        UIView.animate(withDuration: 0.32) {
            
            if self.widthConstraint?.constant == 200 {
                self.widthConstraint?.constant = 100
                self.heightConstraint?.constant = 100
            }else {
                self.widthConstraint?.constant = 200
                self.heightConstraint?.constant = 200
            }
            self.view.layoutIfNeeded()
        }
    }

}
