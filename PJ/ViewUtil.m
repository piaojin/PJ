//
//  ViewUtil.m
//  PJ
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "ViewUtil.h"

@implementation ViewUtil

+ (PJBaseButton *)defaultButton:(NSString *)title frame:(CGRect)frame target:(id)target
                         action:(SEL)action{
    return [[PJBaseButton alloc] init];
}

@end
