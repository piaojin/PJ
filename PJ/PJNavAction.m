//
//  PJNavAction.m
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJNavAction.h"
#import "PJBaseViewController.h"
#import "PJBaseWebViewController.h"
#import "StringUtil.h"
#import "PJ.h"


@implementation PJNavAction

+ (void)toRootVCWithQuery:(NSDictionary*)quey{
    UINavigationController* nav = nil;
    if (nav.viewControllers.count > 1) {
        [nav popToRootViewControllerAnimated:YES];
    }
}

+ (UIViewController *)pushVCWithName:(NSString *)name andQuery:(NSDictionary *)query{
    return [PJNavAction pushVCWithName:name andQuery:query animated:YES];
}

+ (UIViewController *)systemPushVCWithName:(NSString *)name andQuery:(NSDictionary *)query{
    return [PJNavAction systemPushVCWithName:name andQuery:query animated:YES];
}

//用于返回UIViewController,前一个页面可以使用
+ (UIViewController *)systemPushVCWithName:(NSString *)name andQuery:(NSDictionary *)query animated:(BOOL)animated {
    // 参数 判断  String +
    UIViewController *topController = [PJNavAction getCurrentViewController];
    PJBaseViewController *controller = [[NSClassFromString(name) alloc] initWithQuery:query];
    if (controller) {
        controller.systemPush = YES;
        controller.hidesBottomBarWhenPushed = YES;
        if (query) {
            controller.query = query;
        }
        
        if ([controller backButtonTilte]) {
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:[controller backButtonTilte] style:UIBarButtonItemStylePlain target:nil action:nil];
            topController.navigationItem.backBarButtonItem = item;
        }
        [topController.navigationController pushViewController:controller animated:animated];
        return controller;
        
    }else{
        NSLog(@"ViewController name (%@) is not found ",name);
        return nil;
    }
}

//用于返回UIViewController,前一个页面可以使用
+ (UIViewController *)pushVCWithName:(NSString *)name andQuery:(NSDictionary *)query animated:(BOOL)animated {
    // 参数 判断  String +
    UIViewController *topController = [PJNavAction getCurrentViewController];
    PJBaseViewController *controller = [[NSClassFromString(name) alloc] initWithQuery:query];
    if (controller) {
        controller.hidesBottomBarWhenPushed = YES;
        if (query) {
            controller.query = query;
        }
        
        if ([controller backButtonTilte]) {
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:[controller backButtonTilte] style:UIBarButtonItemStylePlain target:nil action:nil];
            topController.navigationItem.backBarButtonItem = item;
        }
        if(topController.navigationController) {
            [topController.navigationController pushViewController:controller animated:animated];
        }else{
            [topController presentViewController:controller animated:animated completion:^{
                
            }];
        }
        return controller;
    }else{
        NSLog(@"ViewController name (%@) is not found ",name);
        return nil;
    }
}

+ (UIViewController *)presentVCWithName:(NSString *)name andQuery:(NSDictionary *)query {
    
    UIViewController *topController = [PJNavAction getCurrentViewController];
    
    PJBaseViewController *controller = [[NSClassFromString(name) alloc] initWithQuery:query];
    if (controller) {
        controller.hidesBottomBarWhenPushed = YES;
        if ([controller backButtonTilte]) {
            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:[controller backButtonTilte] style:UIBarButtonItemStylePlain target:nil action:nil];
            topController.navigationItem.backBarButtonItem = item;
        }
        
        UINavigationController* navVC = [[UINavigationController alloc]initWithRootViewController:controller];
        [topController.navigationController presentViewController:navVC animated:YES completion:^{}];
        return controller;
    } else {
        NSLog(@"ViewController name (%@) is not found ",name);
        return nil;
    }
}

//根据配置跳转至webview页面
+ (UIViewController *)pushWebVCWithUrl:(NSString *)url{
    return [self pushWebVCWithUrl:url title:nil];
}

//根据配置跳转至webview页面
+ (UIViewController *)pushWebVCWithUrl:(NSString *)url
                                 title:(NSString *)title{
    if ([StringUtil isEmpty:url]) {
        return nil;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:url forKey:WEB_URL_KEY];
    [dic setValue:title forKey:WEB_TITLE];
    return [PJNavAction pushVCWithName:@"PJBaseWebViewController" andQuery:dic];
}

+ (UIViewController *)pushWebVCWithQuery:(NSDictionary *)query{
    if(query){
        return [PJNavAction pushVCWithName:@"PJBaseWebViewController" andQuery:query];
    }
    NSLog(@"跳转到WebVC得query不能为空!");
    return nil;
}

/*
 * 获取当前屏幕显示的UIViewController
 */
+ (UIViewController *)getCurrentViewController {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder =  nil;
    if ([[window subviews]count]>0) {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    
    /*
     *
     */
    if ([result isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)result;
        if ([tabBarController.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *)tabBarController.selectedViewController;
            result = navigationController.topViewController;
        }
    }
    return result;
}

/*
 * 确保跳转时单独跳转，防止同时多项点击导致跳转错误
 */
+ (BOOL)ensureRedirectSingleFor:(Class)aClass{
    
    UIViewController *topController = [PJNavAction getCurrentViewController];
    if (![topController isKindOfClass:aClass]) {//防止同时点击，进而页面跳转出错
        return NO;
    }
    
    return  YES;
}

@end
