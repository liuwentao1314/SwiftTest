//
//  UIBarButtonItem-Extension.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/11.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
     //类方法
    class func createItem(imageName : String, size : CGSize, point : CGPoint) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn .setImage(UIImage(named: imageName), for: .normal)
        btn.frame = CGRect(origin: point, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
 */
    
    //便利构造函数
    convenience init(imageName : String, size : CGSize, point : CGPoint) {
        let btn = UIButton()
        
        btn .setImage(UIImage(named: imageName), for: .normal)
        btn.frame = CGRect(origin: point, size: size)
        self.init(customView : btn)
    }
    
}
