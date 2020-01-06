//
//  YNCookieManager.m
//  Pods-YNCookieManager_Example
//
//  Created by lyn on 2020/1/6.
//

#import "YNCookieManager.h"
#import "NSHTTPCookie+Util.h"
@implementation YNCookieManager
+ (void)syncRequestCookie:(NSMutableURLRequest *)request {
    if (!request.URL) {
        return;
    }
    
    NSArray *availableCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage].cookies;
    if (availableCookie.count > 0) {
        //防止Cookie丢失
        NSDictionary *dict = [NSHTTPCookie requestHeaderFieldsWithCookies:[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies];
        if (dict.count) {
            NSMutableDictionary *mDict = request.allHTTPHeaderFields.mutableCopy;
            if (mDict) {
                [mDict setValuesForKeysWithDictionary:dict];
                request.allHTTPHeaderFields = mDict;
            }else{
                request.allHTTPHeaderFields = dict;
            }
        }
    }
}

+ (WKUserScript *)futhureCookieScript{
    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource:[self cookieString] injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    return cookieScript;
}

+ (NSString *)cookieString
{
    NSMutableString *script = [NSMutableString string];
    [script appendString:@"var cookieNames = document.cookie.split('; ').map(function(cookie) { return cookie.split('=')[0] } );\n"];
    for (NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        
        if ([cookie.value rangeOfString:@"'"].location != NSNotFound) {
            continue;
        }
        [script appendFormat:@"if (cookieNames.indexOf('%@') == -1) { document.cookie='%@'; };\n", cookie.name,cookie.formatCookieString];
    }
    return script;
}
@end
