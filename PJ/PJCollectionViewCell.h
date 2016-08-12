//
//  PJCollectionViewCell.h
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJBaseButton.h"

@class PJCollectionViewModel;

@interface PJCollectionViewCell : UICollectionViewCell{
    UIView *_bg;
    PJBaseButton *_coverBtn;
    PJCollectionViewModel *_object;
}

- (id)object;

- (void)setObject:(id)object;

+ (CGFloat)collectionView:(UICollectionView *)collectionView rowHeightForObject:(id)object;

- (void)gridClick;

//设置点按效果的
- (void)setCoverBtnEnable;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
