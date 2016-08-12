//
//  PJEmptyView.m
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJEmptyView.h"

@implementation PJEmptyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptyClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if(self){
        [self initView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptyClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)initView {
    //    UILabel *label = [[UILabel alloc] init];
    //    label.text = @"空空如也";
    //    [label sizeToFit];
    //    label.frame = CGRectMake((self.frame.size.width - label.frame.size.width) / 2.0, (self.frame.size.height - label.frame.size.height) / 2.0, label.frame.size.width, label.frame.size.height);
    //    [self addSubview:label];
}

- (void)emptyClick:(UITapGestureRecognizer *)tap{
    if(self.delegate && [self.delegate respondsToSelector:@selector(emptyClick)]){
        [self.delegate emptyClick];
    }
}

@end
