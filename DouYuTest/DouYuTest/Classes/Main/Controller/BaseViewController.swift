//
//  BaseViewController.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/4/2.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var contentView : UIView?
    
    fileprivate lazy var animImageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!,UIImage(named: "img_loading_3")!,UIImage(named: "img_loading_4")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

extension BaseViewController {
    @objc func setupUI()  {
//        contentView?.isHidden = true
//        view.addSubview(animImageView)
//        animImageView.startAnimating()
//
//        view.backgroundColor = UIColor.white

    }
    
    func showLoadingView()  {
        contentView?.isHidden = true
        view.addSubview(animImageView)
        animImageView.startAnimating()
        
        view.backgroundColor = UIColor.white
    }
    
    func hiddenLoadingView() {
    
        animImageView.stopAnimating()
        animImageView.isHidden = true
        contentView?.isHidden = false
    }
}
