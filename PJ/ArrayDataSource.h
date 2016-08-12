//
//  PJBaseTableViewDataSource.h
//  PJ
//
//  Created by piaojin on 16/7/28.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PJBaseTableViewDataSource.h"


typedef void (^TableViewCellConfigureBlock)(id cell, id item);


@interface ArrayDataSource : PJBaseTableViewDataSource

//- (id)initWithItems:(NSArray *)anItems
//     cellIdentifier:(NSString *)aCellIdentifier
// configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

@end
