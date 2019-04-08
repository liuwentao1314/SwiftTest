//
//  GameViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/22.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (ScreenWidth - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeadrViewH : CGFloat = 50

private let gameCellId = "gameCellId"
private let gameHeaderCellId = "gameHeaderCellId"

class GameViewController: BaseViewController {
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: kHeadrViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        //让collectionView随着宽高拉伸而拉伸
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
       
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gameCellId)
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: gameHeaderCellId)
        return collectionView
    }()

//    override func viewDidLoad() {
//        super.viewDidLoad()

//        setupUI()

//    }
}

//MARK: 设置UI界面
extension GameViewController {
    
    override func setupUI() {
        contentView = collectionView
        self.view .addSubview(collectionView)
        super.setupUI()
        
    }
}

//MARK: UICollectionViewDataSource
extension GameViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCellId, for: indexPath)
        cell.backgroundColor = UIColor.white
//        cell.backgroundColor = UIColor.randomColor()
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: gameHeaderCellId, for: indexPath) as! CollectionHeaderView
        
        headerView.titleLabel.text = "全部"
        headerView.moreBtn.isHidden = true
       
        return headerView
        
    }
    
}
