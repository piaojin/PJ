//
//  PJBaseWebViewController.h
//  PJ
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJBaseModelViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface PJBaseWebViewController : PJBaseModelViewController<UIWebViewDelegate, UIActionSheetDelegate,NJKWebViewProgressDelegate>{
    
    UIButton *_webBackBtn;
    UIButton *_backBtnClose;
    
    NSMutableURLRequest *request;
    
    NJKWebViewProgress *_progressProxy;
    NJKWebViewProgressView *_progressView;
    
    BOOL _isWithParam;
    
    BOOL _isFreshWebView;
    
    UIButton *_navRefreshBtn;
    BOOL _showNavRefreshBtn;
    
    NSString *_contentType;
}

@property(nonatomic, strong) UIWebView * webView;

@property(nonatomic, strong) NSString *reqUrl;


- (void)openRequest:(NSString *)_url;

@end
