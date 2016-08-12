//
//  PJBaseViewController.h
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PJBaseViewModel,PJBaseModel,PJEmptyView,PJErrorView;
#define _GET @"GET"
#define _POST @"POST"

@interface PJBaseViewController : UIViewController

//空视图
@property (strong, nonatomic)PJEmptyView *emptyView;
//出错视图
@property (strong, nonatomic)PJErrorView *errorView;
//用于各个控制器之间传值
@property (strong, nonatomic)NSDictionary *query;
//数据模型
@property (strong, nonatomic)PJBaseModel *pjBaseModel;
//是否采用系统的push方式
@property (nonatomic, assign) BOOL systemPush;
/*
 * 控制器传值
 *
 */
- (id)initWithQuery:(NSDictionary *)query;

/**
 *   初始化导航栏
 */
- (void)initNavigationController;

/**
 * 返回方法,可自定义重写,可以控制动画效果
 */
- (void)backView:(BOOL)animated;
/**
 * 显示正在加载
 */
- (void)showLoading:(BOOL)show;

/**
 * 显示空页面
 */
- (void)showEmpty:(BOOL)show;

/**
 * 自定义返回按钮 文字设置 若需要则重载
 */
- (NSString *)backButtonTilte;

/**
 * 显示加载失败页面
 */
- (void)showError:(BOOL)show;

/**
 * 加载失败页面frame
 */
- (CGRect)getErrorViewFrame;

/**
 * 空页面frame
 */
- (CGRect)getEmptyFrame;

@end
