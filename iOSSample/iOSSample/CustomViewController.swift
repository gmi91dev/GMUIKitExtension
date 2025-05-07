//
//  CustomViewController.swift
//  iOSSample
//
//  Created by gmi91 on 2025/5/2.
//

import UIKit
import GMUIKitExtension

class CustomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .random
        
        UILabel()
            .gmText("CustomViewController", font: .systemFont(ofSize: 26))
            .gmAdd(to: view)
            .gmCenter()
    }

}
