//
//  MDetailViewController.m
//  mRNA
//
//  Created by zhangys on 2017/6/26.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import "MDetailViewController.h"
#import <WebKit/WebKit.h>
#import "MItem.h"

@interface MDetailViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView * webView;

@end

@implementation MDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"攻略详情";
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.webView.navigationDelegate = self;
    // 加载数据
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.item.content_url]]];
    [self.view addSubview:self.webView];
}

#pragma mark - WKWebView WKNavigationDelegate 相关
/// 是否允许加载网页 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self showHUDWithMsg:@"数据加载中..."];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{

}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self showHUDWithMsg:@"出错啦~"];
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

@end
