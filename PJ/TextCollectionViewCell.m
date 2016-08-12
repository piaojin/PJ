//
//  TextCollectionViewCell.m
//  PJ
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "TextCollectionViewCell.h"
#import "PJ.h"
#import "TestCollectionModel.h"

@interface TextCollectionViewCell ()

@property (strong, nonatomic)UILabel *label;

@end

@implementation TextCollectionViewCell

+ (CGFloat)collectionView:(UICollectionView *)collectionView rowHeightForObject:(id)object{
    return 44.0;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initView];
    }
    return self;
}

- (void)initView{
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 30, 20)];
    self.label.text = @"piaojin";
    [self.contentView addSubview:self.label];
    self.label.textColor = [UIColor blackColor];
    self.backgroundColor = PJRandomColor;
}

- (void)setObject:(id)object{
    self.label.text = ((TestCollectionModel *)object).hello;
    [self.label sizeToFit];
}

@end
