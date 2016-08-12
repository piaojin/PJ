//
//  PJBaseTableViewCell.m
//  PJ
//
//  Created by piaojin on 16/7/28.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJBaseTableViewCell.h"

@implementation PJBaseTableViewCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object{
    /**
     *   此处可以通过object计算cell的高度
     */
    return 44.0;
}

- (id)model{
    return nil;
}

//子类重写,更新cell数据
- (void)setModel:(id)model{
    
}

@end
