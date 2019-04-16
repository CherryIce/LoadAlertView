//
//  ICEWKWeViewController.m
//  LoadAlertView
//
//  Created by doman on 2019/3/27.
//  Copyright © 2019年 doman. All rights reserved.
//

#import "ICEWKWeViewController.h"
#import <WebKit/WebKit.h>

@interface ICEWKWeViewController ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>

@property (nonatomic,strong) WKWebView *webView;

@property (nonatomic,strong) WKWebViewConfiguration *webConfiguration;

@end

@implementation ICEWKWeViewController

- (WKWebViewConfiguration *)webConfiguration
{
    if (!_webConfiguration) {
        _webConfiguration = [[WKWebViewConfiguration alloc] init];
        _webConfiguration.userContentController = [[WKUserContentController alloc] init];
    }
    return _webConfiguration;
}

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) configuration:self.webConfiguration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        //_webView.scrollView.bounces = false;
        _webView.scrollView.showsVerticalScrollIndicator = false;
        [_webView setAllowsBackForwardNavigationGestures:true];
        [self.view addSubview:self.webView];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //注册导航方法
    [self.webConfiguration.userContentController addScriptMessageHandler:self name:@"gpsNavigation"];
    
    NSString *timeStamps = @"1555399314877";
    NSString *signs = @"E10B59C7ADCAFFA07A7E8C89A5F7C2057DC24D9F";
    NSString *token = @"37a0527bcb45418e885519afe42f2627";
    NSString *buildingId = @"5cb42604f3eb261abc7b16d4";
    _url = @"http://10.10.1.21:8080/fdym/auth/H5/buildingdetail";
    
    //一下方法亲测有用!!!
    NSDictionary * dict = @{@"token":token,@"sign":signs,@"posttime":timeStamps,@"buildingId":buildingId};
    // 最终要执行的JS代码
    NSString * js = [NSString stringWithFormat:@"%@my_post(\"%@\", %@)",POST_JS,_url,[ICEToolsHelper convertToJsonData:dict]];
    // 执行JS代码
    [self.webView evaluateJavaScript:js completionHandler:nil];

}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    NSLog(@"didStartProvisionalNavigation");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}

/** 与后台协商方法调用 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"gpsNavigation"]) {
        //code... UserInfo.userInfo.name
        NSDictionary * d = message.body;
        NSLog(@">>>>>>%@",d);
    }
}

- (void)dealloc{
    [self.webConfiguration.userContentController removeScriptMessageHandlerForName:@"gpsNavigation"];
    // [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
