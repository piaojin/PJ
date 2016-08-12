//
//  TestCollectionViewDataSource.m
//  PJ
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "TestCollectionViewDataSource.h"
#import "TestCollectionModel.h"
#import "TextCollectionViewCell.h"

@implementation TestCollectionViewDataSource

- (Class)collectionView:(UICollectionView *)collectionView cellClassForObject:(id)object{
    if(object && [object isKindOfClass:[TestCollectionModel class]]){
        return [TextCollectionViewCell class];
    }
    return [super collectionView:collectionView cellClassForObject:object];
}

@end
