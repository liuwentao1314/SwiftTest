//
//  ViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/2/18.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit
import Alamofire
private let kHomeCellId = "kHomeCellId"


class ViewController: UIViewController {

    fileprivate lazy var tableView : UITableView = {[unowned self] in
        
        let tableView = UITableView()
        tableView.frame = self.view.frame
        tableView.dataSource = self
        tableView .register(UITableViewCell.self, forCellReuseIdentifier: kHomeCellId)
        
        return tableView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        loadData()
        
    }
}

//MARK:- 网络请求
extension ViewController{
    fileprivate func loadData() {
        
        HTTPRequestTools.requestData(urlString: "https://java.qingbei.com/api/homePage/v1/subject-courses", type: .get) { (result : Any) in
            print(result)
        }
        
    }
}

//MARK: 实现tableView的数据源
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kHomeCellId, for: indexPath)
        cell.textLabel?.text = "测试数据\(indexPath.row)"
        return cell
    }
}
