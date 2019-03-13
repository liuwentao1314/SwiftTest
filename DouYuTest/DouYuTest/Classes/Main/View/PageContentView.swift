//
//  PageContentView.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/11.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

class PageContentView: UIView {
    
    private var childVCs : [UIViewController]
    private var parentViewController : UIViewController

    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController) {
        self.childVCs = childVcs
        self.parentViewController = parentViewController
        
        super .init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
