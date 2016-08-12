//
//  TestTableViewCell.m
//  PJ
//
//  Created by piaojin on 16/7/28.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "TestTableViewCell.h"
#import "TestModel.h"

// 颜色
#define PJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define PJRandomColor PJColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface TestTableViewCell ()

@property (strong, nonatomic)UILabel *label;

@end

@implementation TestTableViewCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    return 100.0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifie];
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

- (void)setModel:(id)model{
    //[model isKindOfClass:[NSObject class]model是否是你规定的类型
    if(model && [model isKindOfClass:[TestModel class]]){
        self.label.text = ((TestModel *)model).hello;
        [self.label sizeToFit];
    }
}

@end
