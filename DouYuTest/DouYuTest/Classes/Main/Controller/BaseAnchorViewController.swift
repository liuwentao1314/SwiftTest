//
//  BaseAnchorViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/4/2.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

let kItemMargin : CGFloat = 10
let kNormalItemW : CGFloat = (ScreenWidth - 3 * kItemMargin)/2
let kNormalItemH : CGFloat = kNormalItemW * 3/4
let kPrettyItemH : CGFloat = kNormalItemW * 4/3
let kHeaderViewH : CGFloat = 50


private let cellId = "cellId"
let prettyCellId = "prettyCellId"
private let sessionHeaderId = "sessionHeaderId"

class BaseAnchorViewController: BaseViewController {
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: ScreenWidth, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        //设置collectionView 宽度高度随着父控件缩小而缩小
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collectionView.register(UINib(nibName: "CollectionNormalViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        collectionView.register(UINib(nibName: "CollectionPrettyViewCell", bundle: nil), forCellWithReuseIdentifier: prettyCellId)
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sessionHeaderId)

        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

}


//MARK: 设置UI界面
extension BaseAnchorViewController {
    
    override func setupUI() {
        
        contentView = collectionView
        view.addSubview(collectionView)
        
        super.setupUI()
        
    }
}


//MARK: UICollectionViewDelegate
extension BaseAnchorViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionNormalViewCell
//        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sessionHeaderId, for: indexPath) as! CollectionHeaderView
        headerView.backgroundColor = UIColor.white
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let type : Int = Int(arc4random() % 2)
        
        type == 0 ? pushNormalRoomVC() : presentShowRoomVC()
        
        
    }
    
    private func presentShowRoomVC() {
//        let showRoomVC = RoomShowViewController()
//
//        present(showRoomVC, animated: true, completion: nil)
    }
    private func pushNormalRoomVC() {
        let normalRoomVC = RoomNormalViewController()
        
        navigationController?.pushViewController(normalRoomVC, animated: true)
    }
}
