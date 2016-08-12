//
//  PJBaseViewController.m
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJBaseViewController.h"
#import "PJBaseViewModel.h"
#import "PJBaseModel.h"
#import "PJEmptyView.h"
#import "PJErrorView.h"

@interface PJBaseViewController ()<PJEmptyViewDelegate,PJErrorViewDelegate>

@end

@implementation PJBaseViewController

/*
 * 控制器传值
 *
 */
- (id)initWithQuery:(NSDictionary *)query {
    self = [super init];
    if (self) {
        if (query) {
            self.query = query;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *   初始化导航栏
 */
- (void)initNavigationController{
    if(self.navigationController){
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        self.navigationController.navigationBarHidden = NO;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_normal-1"] style:UIBarButtonItemStylePlain target:self action:@selector(backView:)];
    }
}

/**
 * 返回方法,可自定义重写,可以控制动画效果
 */
- (void)backView:(BOOL)animated{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma setter,getter

/**
 * 自定义返回按钮 文字设置 若需要则重载
 */
- (NSString *)backButtonTilte{
    return nil;
}

#pragma 空页面点击事件
- (void)emptyClick{
    
}

#pragma error页面点击事件
- (void)errorClick{
    
}

/**
 * 显示空页面
 */
- (void)showEmpty:(BOOL)show{
    if (show) {
        if(!_emptyView){
            [self.view addSubview:self.emptyView];
        }
        [self.view bringSubviewToFront:_emptyView];
        _emptyView.backgroundColor = [self.view backgroundColor];
        self.emptyView.hidden = NO;
    } else {
        self.emptyView.hidden = YES;
    }
}

//空视图子类可以重写
- (PJEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[PJEmptyView alloc] initWithFrame:[self getEmptyFrame]];
        _emptyView.hidden = YES;
        _emptyView.delegate = self;
    }
    
    return _emptyView;
}

- (CGRect)getEmptyFrame{
    return self.view.bounds;
}

/**
 * 显示加载失败页面
 */
- (void)showError:(BOOL)show{
    if (show) {
        if (!_errorView) {
            [self.view addSubview:self.errorView];
        }
        [self.view bringSubviewToFront:_errorView];
        _errorView.backgroundColor = [self.view backgroundColor];
        [self.view bringSubviewToFront:_errorView];
        self.errorView.hidden = NO;
    }
    else{
        self.errorView.hidden = YES;
    }
}

//出错页面子类可以重写
- (PJErrorView *)errorView{
    if(!_errorView){
        _errorView = [[PJErrorView alloc] init];
        _errorView.frame = [self getErrorViewFrame];
        _errorView.delegate = self;
    }
    return _errorView;
}

- (CGRect)getErrorViewFrame{
    return self.view.bounds;
}

- (void)showLoading:(BOOL)show{
    
}
@end
