//
//  PJBaseTableViewDataSource.h
//  PJ
//
//  Created by piaojin on 16/7/28.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "ArrayDataSource.h"
#import "TestTableViewCell.h"
#import "PJBaseModel.h"
#import "TestModel.h"


@interface ArrayDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end


@implementation ArrayDataSource

//- (id)initWithItems:(NSArray *)anItems
//     cellIdentifier:(NSString *)aCellIdentifier
// configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
//{
//    self = [super init];
//    if (self) {
//        self.items = anItems;
//        self.cellIdentifier = aCellIdentifier;
//        self.configureCellBlock = [aConfigureCellBlock copy];
//    }
//    return self;
//}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}

/**
 *子类可以重写，已达到子类的要求
 *
 */
#pragma PJBaseTableViewDataSource 代理
- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath{
    id item = [self itemAtIndexPath:indexPath];
    return item;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)model{
    if(model && [model isKindOfClass:[TestModel class]]){
        return [TestTableViewCell class];
    }
    return [super tableView:tableView cellClassForObject:model];
}

- (NSIndexPath *)tableView:(UITableView *)tableView indexPathForObject:(id)object{
    return [self tableView:tableView indexPathForObject:object];
}

- (void)tableView:(UITableView *)tableView cell:(UITableViewCell *)cell willAppearAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
