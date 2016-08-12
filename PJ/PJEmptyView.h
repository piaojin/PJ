//
//  PJEmptyView.h
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PJEmptyViewDelegate <NSObject>

- (void)emptyClick;

@end

@interface PJEmptyView : UIView

@property (weak, nonatomic)id<PJEmptyViewDelegate> delegate;

@end
