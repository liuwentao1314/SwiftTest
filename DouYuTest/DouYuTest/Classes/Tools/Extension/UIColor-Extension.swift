//
//  UIColor-Extension.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/13.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
}
