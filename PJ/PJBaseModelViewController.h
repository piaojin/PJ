//
//  PJBaseModelViewController.h
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJBaseViewController.h"
@class PJBaseViewModel;

//刷新类型
typedef NS_ENUM(NSInteger, PullLoadType) {
    PullDefault = 0,
    PullDownRefresh = 1,
    PullUpLoadMore  = 2,
};

@interface PJBaseModelViewController : PJBaseViewController

//数据请求
@property (strong, nonatomic)PJBaseViewModel *pjBaseViewModel;
//数据源
@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, assign) BOOL isLoading;
//每次网络请求返回的新的数据量
@property(nonatomic, assign) NSInteger newItemsCount;
/**
 *  是否正在上拉刷新
 */
@property(nonatomic, assign) BOOL isPullingUp;

//请求参数
@property (strong, nonatomic)NSMutableDictionary *params;
//网络请求方式(GET,POST)
@property (copy, nonatomic)NSString *way;

/**
 *  请求地址，需要子类重写
 */
- (NSString *)requestUrl;
/**
 *  缓存时间
 */
- (NSUInteger)cacheTime;
/**
 *   添加数据，每次请求完数据调用,item中的数据即是一个个model
 *
 */
- (void)addItems:(NSArray *)item;
/**
 *   添加数据，每次请求完数据调用,item即是一个model
 *
 */
- (void)addItem:(id)item;
/**
 *  发起请求数据
 */
- (void)doRequest:(NSString *)requestWay;
/**
 *  请求完成
 */
- (void)didFinishLoad:(id)success failure:(NSError *)failure;
/**
 *  请求失败
 */
- (void)didFailLoadWithError:(NSError *)failure;
/**
 *  请求完成后数据传递给子类，子类需要重写
 */
- (void)requestDidFinishLoad:(id)success failure:(NSError *)failure;
/**
 *  请求失败后数据传递给子类，子类需要重写
 */
- (void)requestDidFailLoadWithError:(NSError *)failure;
/**
 *  开始请求，子类需要重写
 */
- (void)requestDidStartLoad;
/**
 *  数据开始更新
 */
- (void)onDataUpdated;
/**
 *  加载失败
 */
- (void)onLoadFailed;

/**
 *   url为空
 */
- (void)emptyUrl;

@end
