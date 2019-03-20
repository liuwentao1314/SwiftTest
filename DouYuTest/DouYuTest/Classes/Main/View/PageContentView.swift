//
//  PageContentView.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/11.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {

    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let contentCellID = "contentCellID"

class PageContentView: UIView {
    
    private var childVCs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var startOffsetX : CGFloat = 0
    private var isforbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    
    //懒加载
    private lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
    }()
    
    
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVCs = childVcs
        self.parentViewController = parentViewController
        
        super .init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

extension PageContentView {
    private func setupUI() {
        
        for childVC in childVCs {
            parentViewController?.addChild(childVC)
        }
        
        //添加UICollectionView
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }
}

//MARK: UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.frame
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
}

//MARK: UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isforbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isforbidScrollDelegate { return }
        
        //滑动进度
        var progress : CGFloat = 0
        //原
        var sourceIndex : Int = 0
        //目标
        var targetIndex : Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX {
            //左滑
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else {
            //右滑
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            targetIndex = Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}

//MARK: 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int)  {
        
        isforbidScrollDelegate = true
        
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
    }
}
