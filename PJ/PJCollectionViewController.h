//
//  PJCollectionViewController.h
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJBaseModelViewController.h"
#import "PJCollectionViewDataSource.h"
#import "PJCollectionViewCell.h"

@interface PJCollectionViewController : PJBaseModelViewController<UICollectionViewDelegate,PJCollectionViewCellDelegate>

//UICollectionViewDelegateFlowLayout
@property(nonatomic, strong) id <PJCollectionViewDataSource> dataSource;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, assign) PullLoadType pullLoadType;
@property(nonatomic, assign) int page;
@property(nonatomic, assign) BOOL loadMoreEnable;
@property(nonatomic, assign) BOOL loadRefreshEnable;
@property(nonatomic, assign) BOOL forbidLoadMore;
@property(nonatomic, assign) int limit;

- (UICollectionView *)collectionView;

- (void)setCollectionLayout;

- (CGRect)collectionViewFrame;

/**
 *   禁用上拉刷新
 *
 */
- (void)setForbidLoadMore:(BOOL)forbidLoadMore;
/**
 *   禁用下拉刷新
 *
 */
- (void)setForbidRefresh:(BOOL)forbidRefresh;

#pragma mark  - layout  -
//设置collectionView的前后左右的间距
- (UIEdgeInsets)layoutEdgeInsets;

//设置collectionView的内容有几列
- (NSUInteger)numOfRows;

//列间距
- (CGFloat)XPadding;

//行间距
- (CGFloat)YPadding;

#pragma mark- muti custom
- (NSMutableArray *)layoutEdgeInsetsMuti;

//设置collectionView的内容有几列
- (NSMutableArray *)numOfRowsMuti;

//列间距
- (NSMutableArray *)XPaddingMuti;

//行间距
- (NSMutableArray *)YPaddingMuti;

#pragma mark  - layout  -

- (void)createDataSource;

- (void)setPullEndStatus;

//初始化：控制是否下拉刷新
- (BOOL)canPullDownRefreshed;

//初始化：是否上拉更多
- (BOOL)canPullUpLoadMore;

//controller直接调用自动下拉刷新
- (void)autoPullDown;

//控制是否上拉更多
- (void)setLoadMoreEnable:(BOOL)loadMoreEnable;

//控制是否下拉刷新
- (void)setLoadRefreshEnable:(BOOL)loadRefreshEnable;

//每页item数少于limit处理方法
- (void)handleWhenLessOnePage;

//如果无数据则进行处理
- (void)handleWhenNoneData;

//cell 点击跳转方法
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath;

//初始化注册cell&Identifier（多种）
- (void)collectionViewRegisterCellClassAndReuseIdentifier;

@end
