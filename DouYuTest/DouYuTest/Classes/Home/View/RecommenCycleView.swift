//
//  RecommenCycleView.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/21.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

private let kCycleCellId = "kCycleCellId"

class RecommenCycleView: UIView {
    
    var cycleTimer : Timer?
    
    var cycleImgData : [String]? {
        didSet {
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleImgData?.count ?? 0
            
            //设置默认滚动到中间某一位置
            let indexPath = IndexPath(item: (cycleImgData?.count ?? 0)*10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //添加定时器 (先移除在添加)
            removeCycleTimer()
            addCycleTimer()
        }
    }
    
    //MARK: 数据源
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    

    //MARK: 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随父控件的拉伸而拉伸
        autoresizingMask = UIView.AutoresizingMask()
        
        //注册cell
        
        collectionView.register(UINib(nibName: "CycleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellId)

    }
    
    //拿到准确的尺寸
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置collection的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    

}

//MARK: 快速创建view的类方法
extension RecommenCycleView {
    class func recommentCycleView() -> RecommenCycleView {
        return Bundle.main.loadNibNamed("RecommenCycleView", owner: nil, options: nil)?.first as! RecommenCycleView
    }
}

extension RecommenCycleView : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //可以循环滚动  一般设置10000 没有问题
        return (cycleImgData?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellId, for: indexPath) as! CycleCollectionViewCell
        
        let imgUrl = cycleImgData?[indexPath.item % cycleImgData!.count]
        
        cell.imgUrlStr = imgUrl

        return cell
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleImgData?.count ?? 1)

    }
    
    //手动拖拽的时候停止定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
    
}

//MARK :对定时器的操作方法
extension RecommenCycleView {
    private func addCycleTimer()  {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoop.Mode.common)
    }
    
    private func removeCycleTimer() {
        cycleTimer?.invalidate() //从运行循环中移除
        cycleTimer = nil
    }
    
    @objc private func scrollToNext() {
        //获取滚动的偏移量
        let currrntOffsetX = collectionView.contentOffset.x
        //即将h滚动的偏移量
        let offsetX = currrntOffsetX + collectionView.bounds.width
        
        //滚动到该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}
