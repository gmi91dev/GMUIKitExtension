//
//  ViewController.swift
//  iOSSample
//
//  Created by gmi91 on 2025/5/2.
//

import UIKit
import GMUIKitExtension

class ViewController: UIViewController {

    private let cellId = "dataListCell"
    private let datas = ["CustomViews", "AutoLayout"]
    
    private lazy var listView: UITableView = {
        let list = UITableView(frame: .zero)
        list.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        list.dataSource = self
        list.delegate = self
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Examples"
        view.backgroundColor = .random
        
        listView
            .gmAdd(to: view)
            .gmFull()
        
        
                    
    }

    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.selectionStyle = .none
        var config = cell.defaultContentConfiguration()
        config.text = datas[indexPath.row]
        config.textProperties.font = UIFont.systemFont(ofSize: 14)
        cell.contentConfiguration = config
        cell.contentView.backgroundColor = .random
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = CustomViewController()
            vc.title = datas[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = LayoutViewController()
            vc.title = datas[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
}

