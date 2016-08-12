//
//  PJCollectionViewHeaderView.m
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJCollectionViewHeaderView.h"
#import "PJCollectionViewModel.h"

@implementation PJCollectionViewHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)object {
    return _object;
}

- (void)setObject:(id)object {
    if (object != _object) {
        _object = object;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
