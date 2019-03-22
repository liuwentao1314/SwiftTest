//
//  RecommendViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/18.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit
import Alamofire

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (ScreenWidth - 3 * kItemMargin)/2
private let kNormalItemH : CGFloat = kItemW * 3/4
private let kPrettyItemH : CGFloat = kItemW * 4/3
private let kHeaderViewH : CGFloat = 50
private let kCycleViewH : CGFloat = ScreenWidth * 3/8
private let kGameViewH : CGFloat = 90

private let cellId = "cellId"
private let prettyCellId = "prettyCellId"
private let sessionHeaderId = "sessionHeaderId"

class RecommendViewController: UIViewController {

    //MARK: 懒加载
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    private lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
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
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        return collectionView
    }()
    private lazy var cycleView : RecommenCycleView = {
        let cycleView = RecommenCycleView.recommentCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: ScreenWidth, height: kCycleViewH)
        return cycleView
    }()
    private lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: ScreenWidth, height: kGameViewH)
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white

        setupUI()
        
        loadData()
 
    }


}

//MARK: 设置界面
extension RecommendViewController {
    private func setupUI() {
        
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
    }
}

//MARK: 请求数据
extension RecommendViewController {
    private func loadData() {
        recommendVM.requestData()
        
        recommendVM.requestCycleData {
            
            self.cycleView.cycleImgData = self.recommendVM.cycleData
            
        }
    }
}

extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0){
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell : UICollectionViewCell
        
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyCellId, for: indexPath)
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sessionHeaderId, for: indexPath)
        headerView.backgroundColor = UIColor.white
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }else {
            return CGSize(width: kItemW, height: kNormalItemH)
        }
        
    }
}
