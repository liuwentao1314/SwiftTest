//
//  HomeViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/11.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

private let titleViewHeight : CGFloat = 40

class HomeViewController: UIViewController {

    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRect(x: 0, y: 64, width: ScreenWidth, height: titleViewHeight)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupUI()
        
        
    }


}

//MARK: 设置UI界面
extension HomeViewController {
    
    private func setupUI() {
        //不需要调整UIscrollView的e内边距
//        automaticallyAdjustsScrollViewInsets = false
        setupNavBar()
        view .addSubview(pageTitleView)
    }
    
    private func setupNavBar() {
        let btn = UIButton()
        btn .setImage(UIImage(named: "Image_launch_logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        let size = CGSize(width: 40, height: 40)
        let point = CGPoint(x: 0, y: 0)
        
//        let searchBtn = UIButton()
//        searchBtn.setImage(UIImage(named: "ico_home_cate_search"), for: .normal)
//        searchBtn.frame = CGRect(origin: point, size: size)
//        let searchItem = UIBarButtonItem(customView: searchBtn)
        
//        let searchItem = UIBarButtonItem.createItem(imageName: "ico_home_cate_search", size: size, point: point)
        let searchItem = UIBarButtonItem(imageName: "ico_home_cate_search", size: size, point: point)
        
//        let qrcodeBtn = UIButton()
//        qrcodeBtn.setImage(UIImage(named: "home_newSaoicon"), for: .normal)
//        qrcodeBtn.frame = CGRect(origin: point, size: size)
//        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
        
//        let qrcodeItem = UIBarButtonItem.createItem(imageName: "home_newSaoicon", size: size, point: point)
        let qrcodeItem = UIBarButtonItem(imageName: "home_newSaoicon", size: size, point: point)
        
        
        
        navigationItem.rightBarButtonItems = [searchItem,qrcodeItem]
    }
}
