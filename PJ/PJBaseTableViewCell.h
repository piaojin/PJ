//
//  PJBaseTableViewCell.h
//  PJ
//
//  Created by piaojin on 16/7/28.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) id model;

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)model;


@end
