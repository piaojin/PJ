//
//  PJ.h
//  PJ
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#ifndef PJ_h
#define PJ_h


#define WEB_URL_KEY @"webUrl"
#define WEB_TITLE @"webTitle"

#import "StringUtil.h"
#import "NSString+PJ.h"
#import "UIView+PJ.h"

#define Bunndle_AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define IsiPhone6() ([[UIScreen mainScreen] bounds].size.width >= 750/2 ? YES : NO)

// 颜色
#define PJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define PJRandomColor PJColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#endif /* PJ_h */
