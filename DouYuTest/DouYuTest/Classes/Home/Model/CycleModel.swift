//
//  CycleModel.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/21.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    
    var title : String = ""
    
    var picurl : String = ""
    
    //自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    

}
