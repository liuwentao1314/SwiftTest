//
//  RecommendViewModel.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/21.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit

class RecommendViewModel {

    lazy var cycleData : [String] = [String]()
    
}

//MARK: 发送网络请求
extension RecommendViewModel {
    
    
    func requestData()  {
        HTTPRequestTools.requestData(urlString: "http://httpbin.org/get", type: .get, parameters: ["name":"why"]) { (response) in
//            print(response)
        }
    }
    
    //请求无线轮播数据
    func requestCycleData(finishCallback : @escaping () -> () )  {
        HTTPRequestTools.requestData(urlString: "https://java.qingbei.com/api/homePage/v1/banner", type: .get, parameters: ["type" : "1"]) { (result) in
            print(result)
            
            guard let resultDict = result as? [String : AnyObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [String] else { return }
            
            self.cycleData = dataArray

            finishCallback()
        }
    }
}
