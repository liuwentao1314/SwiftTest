//
//  CustomNavigationController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/4/2.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1.获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else {
            return
        }
        //2.获取手势添加到的view
        guard let gesView = systemGes.view else {
            return
        }
        //3.获取target/action
        //3.1利用运行时机制查看所有属性名称
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
        for i in 0..<count {
            let ivar = ivars?[Int(i)]
            let name = ivar_getName(ivar!)
//            print(String(cString: name!))
        }
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else {
            return
        }
//        print(targetObjc)
        //3.2取出target
        guard let target = targetObjc.value(forKey: "target") else {
            return
        }
        //3.3取出action
        let action = Selector(("handleNavigationTransition:"))
        
        
        //4.创建自己的手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
        
        
    }
  
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //当push的时候隐藏tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
        
    }

}
