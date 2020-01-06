//
//  NSHTTPCookie+Util.h
//  SuiShenXueApp
//
//  Created by lyn on 2020/1/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSHTTPCookie (Util)
/**
 format cookie to string
 
 @return cookieStringValue
 */
- (NSString *)formatCookieString;
@end

NS_ASSUME_NONNULL_END
