//
//  TestCollectionViewController.m
//  PJ
//
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "TestCollectionViewController.h"
#import "PJTestViewModel.h"
#import "PJBaseViewModel.h"
#import "TestCollectionViewDataSource.h"
#import "TestCollectionModel.h"

@interface TestCollectionViewController ()

//数据请求
@property (strong, nonatomic)PJTestViewModel *pjBaseViewModels;

@property (assign, nonatomic)int count;

@end

@implementation TestCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doRequest:@"GET"];
    self.count = 1;
    [self setForbidLoadMore:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)createDataSource{
    self.dataSource = [TestCollectionViewDataSource dataSourceWithItems:self.items];
}

- (NSString *)requestUrl{
    NSLog(@"子类requestUrl");
    return @"http://gc.ditu.aliyun.com/regeocoding?l=39.938133,116.395739&type=001";
}

- (void)requestDidFinishLoad:(id)success failure:(NSError *)failure{
    NSLog(@"success:%@",success);
    //模拟解析完网络返回的数据
    TestCollectionModel *m1 = [[TestCollectionModel alloc] init];
    m1.hello = @"hello world";
        if(self.count ==1 ){
            NSMutableArray *dataArray = [NSMutableArray array];
            [dataArray addObject:m1];
            [dataArray addObject:m1];
            [dataArray addObject:m1];
            [dataArray addObject:m1];
            [dataArray addObject:m1];
            [dataArray addObject:m1];
            [self addItems:dataArray];
            self.count++;
        }else{
            NSMutableArray *dataArray = [NSMutableArray array];
            [dataArray addObject:m1];
            [dataArray addObject:m1];
            [dataArray addObject:m1];
            [self addItems:dataArray];
        }
//    NSMutableArray *dataArray = [NSMutableArray array];
//    [dataArray addObject:m1];
//    [dataArray addObject:m1];
//    [dataArray addObject:m1];
//    [dataArray addObject:m1];
//    [dataArray addObject:m1];
//    [dataArray addObject:m1];
//    [self addItems:dataArray];
    //    [self createDataSource];
}

- (void)requestDidFailLoadWithError:(NSError *)failure{
    NSLog(@"failure:%@",failure);
}

- (PJBaseViewModel *)pjBaseViewModel{
    NSLog(@"pjBaseViewModel");
    if(!_pjBaseViewModels){
        _pjBaseViewModels = [[PJTestViewModel alloc] init];
    }
    return _pjBaseViewModels;
}

@end
