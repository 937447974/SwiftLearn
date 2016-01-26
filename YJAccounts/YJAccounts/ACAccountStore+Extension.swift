//
//  ACAccountStore+Extension.swift
//  YJAccounts
//
//  CSDN:http://blog.csdn.net/y550918116j
//  GitHub:https://github.com/937447974/Blog
//
//  Created by yangjun on 16/1/26.
//  Copyright © 2016年 阳君. All rights reserved.
//

import Accounts

/// ACAccountStore扩展
public extension ACAccountStore {
    
    // MARK: Facebook请求授权
    /// Facebook请求授权
    ///
    /// - parameter completion: ACAccountStoreRequestAccessCompletionHandler
    ///
    /// - returns: void
    func requestFacebookAccess(completion: ACAccountStoreRequestAccessCompletionHandler) {
        let options: [NSObject : AnyObject] = [ACFacebookAppIdKey: "MY_CODE", ACFacebookPermissionsKey: ["email", "user_about_me"], ACFacebookAudienceKey: ACFacebookAudienceFriends]
        self.requestAccessToAccountsWithTypeIdentifier(ACAccountTypeIdentifierFacebook, options: options, completion: completion)
    }
    
    // MARK: Twitter请求授权
    /// Twitter请求授权
    ///
    /// - parameter completion: ACAccountStoreRequestAccessCompletionHandler
    ///
    /// - returns: void
    func requestTwitterAccess(completion: ACAccountStoreRequestAccessCompletionHandler) {
        self.requestAccessToAccountsWithTypeIdentifier(ACAccountTypeIdentifierTwitter, options: nil, completion: completion)
    }
    
    // MARK: SinaWeibo请求授权
    /// SinaWeibo请求授权
    ///
    /// - parameter completion: ACAccountStoreRequestAccessCompletionHandler
    ///
    /// - returns: void
    func requestSinaWeiboAccess(completion: ACAccountStoreRequestAccessCompletionHandler) {
        self.requestAccessToAccountsWithTypeIdentifier(ACAccountTypeIdentifierSinaWeibo, options: nil, completion: completion)
    }
    
    // MARK: TencentWeibo请求授权
    /// TencentWeibo请求授权
    ///
    /// - parameter completion: ACAccountStoreRequestAccessCompletionHandler
    ///
    /// - returns: void
    func requestTencentWeiboAccess(completion: ACAccountStoreRequestAccessCompletionHandler) {
        self.requestAccessToAccountsWithTypeIdentifier(ACAccountTypeIdentifierTencentWeibo, options: nil, completion: completion)
    }
    
    // MARK: - private
    // MARK: 请求授权
    private func requestAccessToAccountsWithTypeIdentifier(typeIdentifier: String, options: [NSObject : AnyObject]?, completion: ACAccountStoreRequestAccessCompletionHandler) {
        let accountType = self.accountTypeWithAccountTypeIdentifier(typeIdentifier)
        // When requesting access to the account is when the user will be prompted for consent.
        self.requestAccessToAccountsWithType(accountType, options: options, completion: completion)
    }
    
}