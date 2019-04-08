//
//  FunnyViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/4/2.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

class FunnyViewController: BaseAnchorViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }

}

extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        
    }
}
