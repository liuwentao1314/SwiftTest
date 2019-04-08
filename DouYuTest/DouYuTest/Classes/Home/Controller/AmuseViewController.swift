//
//  AmuseViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/4/1.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

fileprivate let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {

    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: ScreenWidth, height: kMenuViewH)
        return menuView
    }()
    
    
    //MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
    }
}

extension AmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

extension AmuseViewController {
    fileprivate func reloadData() {
        self.collectionView .reloadData()
    }
}

