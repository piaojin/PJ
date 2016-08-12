//
//  PJCollectionViewCell.m
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJCollectionViewCell.h"
#import "PJCollectionViewModel.h"
#import "ViewUtil.h"

#define SafeCallSelector(instance,selector)  if (instance && [instance respondsToSelector:selector]) { SafePerformSelector([instance performSelector:selector]);}

#define SafePerformSelector(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define IgnoreUndeclaredSelector(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)\

@implementation PJCollectionViewCell
- (void)dealloc {
    [self setObject:nil];
}

+ (CGFloat)collectionView:(UICollectionView *)collectionView rowHeightForObject:(id)object {
    return 88;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _bg = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_bg];
    }
    return self;
}

- (id)object {
    return _object;
}

- (void)prepareForReuse {
    self.object = nil;
    [super prepareForReuse];
}

- (void)setObject:(id)object {
    if (object != _object) {
        _object = object;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)gridClick{
    PJCollectionViewModel *item = (PJCollectionViewModel *)self.object;
    if (item.delegate && [item.delegate respondsToSelector:item.selector])
    { SafePerformSelector(
                          [item.delegate performSelector:item.selector withObject:item]
                          );
    }
}

//设置点按效果的
- (void)setCoverBtnEnable{
    if (!_coverBtn) {
        _coverBtn = [ViewUtil defaultButton:nil frame:self.bounds target:self action:@selector(gridClick)];
        [self addSubview:_coverBtn];
    }
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [_coverBtn removeTarget:self action:@selector(gridClick) forControlEvents:controlEvents];
    [_coverBtn addTarget:target action:action forControlEvents:controlEvents];
}


@end
