//
//  ViewUtil.h
//  PJ
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PJBaseButton.h"

@interface ViewUtil : NSObject

+ (PJBaseButton *)defaultButton:(NSString *)title frame:(CGRect)frame target:(id)target
                         action:(SEL)action;

@end
