//
//  YNCookieManager.h
//  Pods-YNCookieManager_Example
//
//  Created by lyn on 2020/1/6.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YNCookieManager : NSObject

/**
 同步NSHttpCookieStorage到Request请求的httpsHeader中
 
 @param request 需要同步cookie的请求
 */
+ (void)syncRequestCookie:(NSMutableURLRequest *)request;

/**
 获取带NSHttpCookieStorage中Cookie的UserScript
 
 @return 带Cookie的UserScript
 */
+ (WKUserScript *)futhureCookieScript;
@end

NS_ASSUME_NONNULL_END
