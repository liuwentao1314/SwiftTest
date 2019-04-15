//
//  FollowViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/4/11.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class FollowViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray = [String]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        dataArray = ["改变字体"]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }


}

extension FollowViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let customFontVC = CustomFontViewController()
        
        navigationController?.pushViewController(customFontVC, animated: true)
    }
    
}
