//
//  PJCollectionViewModel.h
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PJBaseModel.h"

@interface PJCollectionViewModel : PJBaseModel

@property (nonatomic, weak) id        delegate;
@property (nonatomic, assign) SEL       selector;

@end