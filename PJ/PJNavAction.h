//
//  PJNavAction.h
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PJNavAction : NSObject

+ (void)toRootVCWithQuery:(NSDictionary*)quey;

+ (UIViewController *)pushVCWithName:(NSString*)name andQuery:(NSDictionary*)quey;
// 采用系统push，没有截屏机制，不支持手势侧滑返回！
+ (UIViewController *)systemPushVCWithName:(NSString *)name andQuery:(NSDictionary *)query;

+ (UIViewController *)presentVCWithName:(NSString *)name andQuery:(NSDictionary *)query;

//用于返回UIViewController,前一个页面可以使用
+ (UIViewController *)pushVCWithName:(NSString *)name andQuery:(NSDictionary *)query animated:(BOOL)animated;

// 用于返回UIViewController,前一个页面可以使用 采用系统push，没有截屏机制，不支持手势侧滑返回！
+ (UIViewController *)systemPushVCWithName:(NSString *)name andQuery:(NSDictionary *)query animated:(BOOL)animated ;

//根据配置跳转至webview页面
+ (UIViewController *)pushWebVCWithUrl:(NSString *)url;

//根据配置跳转至webview页面
+ (UIViewController *)pushWebVCWithUrl:(NSString *)url
                                 title:(NSString *)title;
+ (UIViewController *)pushWebVCWithQuery:(NSDictionary *)query;
//获取当前屏幕显示的UIViewController
+ (UIViewController *)getCurrentViewController;

/*
 * 确保跳转时单独跳转，防止同时多项点击导致跳转错误
 */
+ (BOOL)ensureRedirectSingleFor:(Class)aClass;


@end
