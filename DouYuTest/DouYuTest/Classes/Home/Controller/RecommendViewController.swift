//
//  RecommendViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/18.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit
import Alamofire

private let kCycleViewH : CGFloat = ScreenWidth * 3/8
private let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {

    //MARK: 懒加载
    private lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
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
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        loadData()

    }


}

//MARK: 设置界面
extension RecommendViewController {
    //重写父类setupUI方法
     override func setupUI() {
        super.setupUI()
        
        view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
    }
    
}

//MARK: 请求数据
extension RecommendViewController {
    private func loadData() {

        recommendVM.requestData()
        
        showLoadingView()
        
        recommendVM.requestCycleData {
            
            self.cycleView.cycleImgData = self.recommendVM.cycleData
            
            self.hiddenLoadingView()
        }
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyCellId, for: indexPath) as! CollectionPrettyViewCell
            
            return prettyCell
            
        }else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }else {
            return CGSize(width: kNormalItemW, height: kNormalItemH)
        }
        
    }
}

