//
//  PJCollectionViewDataSource.h
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PJCollectionViewLayout.h"

@class PJCollectionViewHeaderView;
@class PJCollectionViewFooterView;

@protocol PJCollectionViewDataSource <UICollectionViewDataSource>

- (id)collectionView:(UICollectionView *)collectionView objectForRowAtIndexPath:(NSIndexPath *)indexPath;

- (Class)collectionView:(UICollectionView *)collectionView cellClassForObject:(id)object;

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView indexPathForObject:(id)object;

@end


@interface PJCollectionViewDataSource : NSObject<PJCollectionViewDataSource, UICollectionViewDelegateFlowLayout, PJCollectionViewLayoutDelegate>{
    NSMutableDictionary *_headerViews;
    NSMutableDictionary *_footerViews;
}

@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, strong) NSMutableArray *mutiItems;


+ (PJCollectionViewDataSource *)dataSourceWithItems:(NSMutableArray *)items;

//用于多Section情况
+ (PJCollectionViewDataSource *)dataSourceWithMutiItems:(NSMutableArray *)items;


#pragma mark ------------header
//header头视图
- (PJCollectionViewHeaderView *)headerView;

//section对应的header头视图
- (PJCollectionViewHeaderView *)headerViewForSection:(NSUInteger)section;

//header头视图
- (PJCollectionViewHeaderView *)constructHeaderView:(UICollectionView *)collectionView;

//section对应的header头视图
- (PJCollectionViewHeaderView *)constructHeaderViewForSection:(NSUInteger)section
                                                      andView:(UICollectionView *)collectionView;

/**
 * header头的高度
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
 heightForHeaderInSection:(NSInteger)section;

- (Class)headerClassForSection:(NSUInteger)section collectionView:(UICollectionView *)collectionView ;

#pragma mark ------------header
//footer视图
- (PJCollectionViewFooterView *)footerView;

//section对应的footer视图
- (PJCollectionViewFooterView *)footerViewForSection:(NSUInteger)section;

//footer视图
- (PJCollectionViewFooterView *)constructFooterView:(UICollectionView *)collectionView;

//section对应的footer视图
- (PJCollectionViewFooterView *)constructFooterViewForSection:(NSUInteger)section
                                                      andView:(UICollectionView *)collectionView;


/**
 * footer的高度
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
 heightForFooterInSection:(NSInteger)section;


@end
