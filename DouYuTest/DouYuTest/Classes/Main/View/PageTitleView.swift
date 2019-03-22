//
//  PageTitleView.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/11.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex Index : Int)
}

private let bottomLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85,85,85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255,128,0)

class PageTitleView: UIView {

    private var titles : [String]
    private var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    
    //懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    
    
    //自定义构造函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    private func setUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLabel()
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabel() {
        
        let labelW : CGFloat = frame.size.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - bottomLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r:kNormalColor.0 , g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView .addSubview(label)
            titleLabels .append(label)
            
            //label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
        
    }
    
    private func setupBottomLineAndScrollLine() {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        scrollView.addSubview(scrollLine)
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-bottomLineH, width: firstLabel.frame.width, height: bottomLineH)
        
    }
}

extension PageTitleView {
    @objc private func titleLabelClick(tapGes : UITapGestureRecognizer) {
        //1.获取当前label下标
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        
        //如果重复点击是一个title，则直接返回
        if currentLabel.tag == currentIndex { return }
        
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //切换label颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r:kNormalColor.0 , g: kNormalColor.1, b: kNormalColor.2)
        
        //保存最新label下标
        currentIndex = currentLabel.tag
        
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//MARK: 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色渐变
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0*progress, g: kSelectColor.1 - colorDelta.1*progress, b: kSelectColor.2 - colorDelta.2*progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
}
