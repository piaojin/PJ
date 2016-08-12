//
//  PJCollectionViewFooterView.h
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PJCollectionViewModel;

@interface PJCollectionViewFooterView : UICollectionReusableView{
    PJCollectionViewModel *_object;
}

- (id)object;

- (void)setObject:(id)object;

@end
