//
//  NSHTTPCookie+Util.m
//  SuiShenXueApp
//
//  Created by lyn on 2020/1/6.
//

#import "NSHTTPCookie+Util.h"

@implementation NSHTTPCookie (Util)
- (NSString *)formatCookieString{
    NSString *string = [NSString stringWithFormat:@"%@=%@;domain=%@;path=%@",
                        self.name,
                        self.value,
                        self.domain,
                        self.path ?: @"/"];
    
    if (self.secure) {
        string = [string stringByAppendingString:@";secure=true"];
    }
    
    return string;
}
@end
