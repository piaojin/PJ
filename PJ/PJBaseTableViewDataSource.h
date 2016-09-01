//
//  PJBaseTableViewDataSource.h
//  PJ
//
//  Created by piaojin on 16/7/28.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PJBaseViewController.h"

@protocol PJBaseTableViewDataSource <UITableViewDataSource>

- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath;

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)object;

- (NSIndexPath *)tableView:(UITableView *)tableView indexPathForObject:(id)object;

- (void)tableView:(UITableView *)tableView cell:(UITableViewCell *)cell willAppearAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PJBaseTableViewDataSource : NSObject <PJBaseTableViewDataSource>

@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, strong) NSMutableArray *sectionsItems;
@property (weak, nonatomic)PJBaseViewController *controller;


/**
 * 只有单组数据
 */
+ (PJBaseTableViewDataSource *)dataSourceWithItems:(NSMutableArray *)items;

/**
 * 分组数据
 */
+ (PJBaseTableViewDataSource *)dataSourceWithSectionsItems:(NSMutableArray *)items;

@end
