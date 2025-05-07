//
//  LayoutViewController.swift
//  iOSSample
//
//  Created by gmi91 on 2025/5/2.
//

import UIKit

class LayoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .random
        
        UILabel()
            .gmText("LayoutViewController", font: .systemFont(ofSize: 26))
            .gmAdd(to: view)
            .gmCenter()
    }

}
