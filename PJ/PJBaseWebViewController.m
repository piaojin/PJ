//
//  PJBaseWebViewController.m
//  PJ
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJBaseWebViewController.h"
#import "PJ.h"

@implementation PJBaseWebViewController

- (void)dealloc {
    [_progressView removeFromSuperview];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (id)initWithQuery:(NSDictionary *)query {
    self = [super initWithQuery:query];
    if (self) {
        _showNavRefreshBtn = YES;
        _isWithParam = NO; //default NO
        if ([[query objectForKey:@"isWithParam"] isEqualToString:@"YES"]) {
            _isWithParam = YES;
        }
        _contentType = [query objectForKey:@"contentType"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.query.count) {
        self.reqUrl = [self.query objectForKey:WEB_URL_KEY];
    }
    
    NSString *title = [StringUtil getString:self.query key:WEB_TITLE];
    if (![StringUtil isEmpty:title]) {
        [self setTitle:title];
    }
    
    [self initWebView];
    [self initProgress];
    [self initBackView];
    
    if (![NSString isEmpty:self.reqUrl]) {
        [self openRequest:self.reqUrl];
    }else{
        NSLog(@"error:webView url为空！");
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.view.window makeKeyWindow];
    [super viewWillDisappear:animated];
    
    [_backBtnClose removeFromSuperview];
    [_webBackBtn removeFromSuperview];
}

- (void)initBackView{
    _webBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _webBackBtn.frame = CGRectMake(0, 20, 70, 44);
    _webBackBtn.backgroundColor = [UIColor clearColor];
    [_webBackBtn addTarget:self
                    action:@selector(backView)
          forControlEvents:UIControlEventTouchUpInside];
    
    _backBtnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtnClose.frame = CGRectMake(IsiPhone6() ? _webBackBtn.right - 15: _webBackBtn.right - 25, 20, 60, 44);
    _backBtnClose.backgroundColor = [UIColor clearColor];
    [_backBtnClose setTitle:@"关闭" forState:UIControlStateNormal];
    [_backBtnClose setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    _backBtnClose.titleLabel.font = [UIFont systemFontOfSize:17];
    [_backBtnClose addTarget:self
                      action:@selector(backViewClose)
            forControlEvents:UIControlEventTouchUpInside];
    [_backBtnClose setHidden:YES];
    
    [self.navigationController.view addSubview:_backBtnClose];
    
    [self.navigationController.view addSubview:_webBackBtn];
}

- (void)refreshAction {
    // 修改刷新 回到最初界面
    [_webView reload];
    _isFreshWebView = YES;
}

- (void)initWebView {
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor clearColor];
    
    _webView.scalesPageToFit = YES;
    if (self.query && [self.query objectForKey:@"ScalesPageToFit"]) {
        _webView.scalesPageToFit = NO;
    }
    [self.view addSubview:_webView];
}

//进度条
- (void)initProgress{
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    _progressView.progressBarView.backgroundColor = [UIColor greenColor];
    [self.navigationController.navigationBar addSubview:_progressView];
    _progressView.progress = 0;
}

- (void)openRequest:(NSString *)_url {
    NSString *reqUrl = nil;
    if (_isWithParam) {
        //有带参数
        
    } else {
        reqUrl = _url;
    }
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:reqUrl]];
    [_webView loadRequest:request];
}


#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:YES];
}

- (void)backViewClose{
    [super backView:YES];
}

- (void)backView {
    if([_webView canGoBack]){
        [_webView goBack];
        
        [_backBtnClose setHidden:NO];
        [self.navigationController.view bringSubviewToFront:_backBtnClose];
        return;
    }
    [super backView:YES];
}

- (BOOL)isWebURL:(NSURL*)URL {
    return [URL.scheme caseInsensitiveCompare:@"http"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"https"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"ftp"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"ftps"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"data"] == NSOrderedSame
    || [URL.scheme caseInsensitiveCompare:@"file"] == NSOrderedSame;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)_request navigationType:(UIWebViewNavigationType)navigationType {
    //  判断是否 属于 app 间跳转  非纯 http 跳转
    if ([[UIApplication sharedApplication] canOpenURL:_request.URL] && ![self isWebURL:_request.URL]) {
        if([[_request.URL scheme] isEqualToString:@"ushengsheng.xjb"])
        {
            
        }else{
            [[UIApplication sharedApplication] openURL:_request.URL];
        }
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //获取html标题
    NSString *title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if ([StringUtil isEmpty:title] && [StringUtil isEmpty:self.title]) {
        title = @"详情";
    }
    if (![StringUtil isEmpty:title]) {
        self.title = [StringUtil subString:title length:13 trail:YES];
    }
    
    if (_isFreshWebView) {
        _isFreshWebView = NO;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

@end
