//
//  HTTPRequestTools.swift
//  DouYuTest
//
//  Created by 华罗庚 on 2019/3/6.
//  Copyright © 2019年 华罗庚. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class HTTPRequestTools: NSObject {
    
    class func requestData(urlString : String, type : MethodType, parameters : [String : Any]? = nil, finishedCallback : @escaping (_ result : Any) -> ()){
        
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        
        Alamofire.request(urlString, method: method, parameters: parameters, headers: ["Accept": "application/json","Content-Type": "application/json"]).responseJSON { (response) in
            if let result = response.result.value{
                finishedCallback(result)
            }else {
                print(response.result.error as Any)
            }
        }
        
    }
    
    

}
