//
//  CustomFontViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/4/11.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

private let cellId = "cellId"

class CustomFontViewController: UIViewController {

    var data = ["30 Days Swift", "这些字体特别适合打「奋斗」和「理想」",
                "谢谢「造字工房」，本案例不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体",
                "呵呵，再见🤗 See you next Project", "微博 @Allen朝辉",
                "测试测试测试测试测试测试", "123", "Alex", "@@@@@@"]
    
    var fontNames = ["MFTongXin_Noncommercial-Regular",
                     "MFJinHei_Noncommercial-Regular",
                     "MFZhiHei_Noncommercial-Regular",
                     "Zapfino",
                     "Gaspar Regular"]
    
    var fontRowIndex = 0
    
    fileprivate lazy var tableView : UITableView = {[unowned self] in
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-200), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    fileprivate lazy var changeFontLabel : UILabel = {
        let changeFontLabel = UILabel(frame: CGRect(x: (ScreenWidth-200)/2, y: ScreenHeight-200, width: 200, height: 200))
        changeFontLabel.text = "改变字体"
        changeFontLabel.textAlignment = NSTextAlignment.center
        changeFontLabel.textColor = UIColor.white
        changeFontLabel.backgroundColor = UIColor.orange
        changeFontLabel.layer.cornerRadius = 50
        changeFontLabel.layer.masksToBounds = true
        // 设置为true才能响应手势
        changeFontLabel.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self,action: #selector(changeFontDidTouch(_:)))
        changeFontLabel.addGestureRecognizer(gesture)
        return changeFontLabel
    }()
    
    @objc func changeFontDidTouch(_ sender: AnyObject) {
        
        fontRowIndex = (fontRowIndex + 1) % 5
        print(fontNames[fontRowIndex])
        tableView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "改变字体"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(tableView)
        self.view .addSubview(changeFontLabel)
    }
}

extension CustomFontViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let text = data[indexPath.row]
        cell.textLabel?.text = text
        cell.textLabel?.font = UIFont(name: self.fontNames[fontRowIndex], size:16)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    
}
