//
//  AmuseMenuViewCell.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/4/2.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

private let kMenuViewCellId = "kMenuViewCellId"

class AmuseMenuViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var group : [String]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuViewCellId)
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width/4
        let itemH = collectionView.bounds.height/2
        layout.itemSize = CGSize(width: itemW, height: itemH)

    }
}

extension AmuseMenuViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuViewCellId, for: indexPath) as! GameCollectionViewCell
        
        cell.clipsToBounds = true

        return cell
    }
    
    
}
