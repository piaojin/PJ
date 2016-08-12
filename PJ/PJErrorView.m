//
//  PJErrorView.m
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJErrorView.h"

@implementation PJErrorView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(errorClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if(self){
        [self initView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(errorClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)initView {
    
}

- (void)errorClick:(UITapGestureRecognizer *)tap{
    if(self.delegate && [self.delegate respondsToSelector:@selector(errorClick)]){
        [self.delegate errorClick];
    }
}

@end
