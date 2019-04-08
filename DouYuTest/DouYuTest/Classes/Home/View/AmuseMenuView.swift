//
//  AmuseMenuView.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/4/2.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

private let kMenuCellId = "kMenuCellId"

class AmuseMenuView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var group : [String] = ["a","s","s","s","s","a","s","s","1","s","a","fss"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib (nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellId)
        
    }
    
    //在这里拿到的frame才准确
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        
    }
    
}
//MARK: 通过xib创建view
extension AmuseMenuView{
    class func amuseMenuView()-> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let pageNum = (group.count - 1) / 8 + 1
        
        pageControl.numberOfPages = pageNum
        
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellId, for: indexPath) as! AmuseMenuViewCell
        
        //给cell设置数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
//        cell.backgroundColor = UIColor.randomColor()
        return cell
        
    }

    fileprivate func setupCellDataWithCell(cell : AmuseMenuViewCell, indexPath: IndexPath) {
        
        let startIndex : Int = indexPath.item * 8
        var endIndex : Int = (indexPath.item + 1) * 8 - 1
        
        if endIndex > group.count - 1 {
            endIndex = group.count - 1
        }

        let arr  = group[startIndex...endIndex]
        cell.group = Array(arr)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
    
}
