//
//  PJErrorView.h
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PJErrorViewDelegate <NSObject>

- (void)errorClick;

@end

@interface PJErrorView : UIView

@property (weak, nonatomic)id<PJErrorViewDelegate> delegate;

@end
