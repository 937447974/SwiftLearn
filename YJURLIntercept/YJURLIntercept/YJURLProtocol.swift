//
//  YJURLProtocol.swift
//  urlTest
//
//  Created by admin on 2016/11/4.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

import UIKit

class YJURLProtocol: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        print(#function)
        if request.url!.absoluteString.hasPrefix("https://www.baidu.com"){
            return true
        }
        print(request)
        return false
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        print(#function)
        print(request)
        let urlReq = NSMutableURLRequest(url: URL(string: "http://map.baidu.com")!);
        URLProtocol.setProperty(true, forKey: "URLProtocolHandledKey", in: urlReq)
        return urlReq as URLRequest
    }
    
    override func startLoading() {
        print(#function)
        let didFailWithError:(Error) -> Swift.Void = {
            (error) in
            print("发送请求出错:\(error.localizedDescription)")
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        let success: (Data, URLResponse) -> Swift.Void = {
            (data: Data, response: URLResponse) in
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: URLCache.StoragePolicy.notAllowed)
            self.client?.urlProtocol(self, didLoad: data)
            self.client?.urlProtocolDidFinishLoading(self)
        }
        let dataTask = URLSession.shared.dataTask(with: self.request) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            data != nil ? success(data!, response!) : didFailWithError(error!)
        }
        dataTask.resume()
    }
    
    override func stopLoading() {
        print(#function)
    }
    
}
