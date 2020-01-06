//
//  YNViewController.m
//  YNCookieManager
//
//  Created by yinuo lu on 01/06/2020.
//  Copyright (c) 2020 yinuo lu. All rights reserved.
//

#import "YNViewController.h"
#import "YNCookieManager.h"
@interface YNViewController ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation YNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configWebView];
}
- (void)configWebView{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    WKUserContentController *contentController = [[WKUserContentController alloc]init];
    //1.把Cookie配置到脚本
    [contentController addUserScript:[YNCookieManager futhureCookieScript]];
    configuration.userContentController = contentController;
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration];
    [self.view addSubview:webView];
    self.webView = webView;
    NSMutableURLRequest *requst = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.baidu.com"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    //2.同步首次请求Cookie
    [YNCookieManager syncRequestCookie:requst];
    [self.webView loadRequest:requst];
}

#pragma mark - WKNavigationDelegete Method
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    /**
     3.【COOKIE 3】对服务器端重定向(302)/浏览器重定向(a标签[包括 target="_blank"]) 进行同步 cookie 处理。
     由于所有的跳转都会是 NSMutableURLRequest 类型，同时也无法单独区分出 302 服务器端重定向跳转，所以这里统一对服务器端重定向(302)/浏览器重定向(a标签[包括 target="_blank"])进行同步 cookie 处理。
     */
    if ([navigationAction.request isKindOfClass:NSMutableURLRequest.class]) {
        [YNCookieManager syncRequestCookie:(NSMutableURLRequest *)navigationAction.request];
    }
    //个人业务代码...
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 收到响应后, 决定是否跳转 -- 要获取response，通过WKNavigationResponse对象获取
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    // 允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
}


@end
