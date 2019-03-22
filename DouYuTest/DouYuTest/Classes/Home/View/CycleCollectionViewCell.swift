//
//  CycleCollectionViewCell.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/21.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit
import Kingfisher

class CycleCollectionViewCell: UICollectionViewCell {
    
    var imgUrlStr : String? {
        didSet {
            let iconURL = NSURL(string: imgUrlStr ?? "")
            
            iconImgView.kf.setImage(with: ImageResource(downloadURL: iconURL! as URL), placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
            
        }
    }
    
    @IBOutlet weak var iconImgView: UIImageView!
    


}
