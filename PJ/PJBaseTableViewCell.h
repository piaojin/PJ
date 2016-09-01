//
//  PJBaseTableViewCell.h
//  PJ
//
//  Created by piaojin on 16/7/28.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJBaseViewController.h"
@protocol PJBaseTableViewCellDelegate <NSObject>

- (void)action:(id)sender withObject:(id)object;

@end
@interface PJBaseTableViewCell : UITableViewCell

@property (nonatomic, strong) id model;
@property (weak, nonatomic)PJBaseViewController *controller;
@property (weak, nonatomic)id<PJBaseTableViewCellDelegate> delegate;

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)model;


@end
