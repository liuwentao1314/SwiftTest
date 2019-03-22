//
//  RecommendGameView.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/22.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

private let gameCellId = "gameCellId"

class RecommendGameView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        //移除Autoresizing
        autoresizingMask = UIView.AutoresizingMask()
        
        
        //注册cell
        
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gameCellId)
       //给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

//MARK: 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//MAEK: collectionViewDataSource
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellId, for: indexPath) as! GameCollectionViewCell
        
        
        return cell
    }
    
    
}
