//
//  ViewController.m
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "ViewController.h"
#import "PJBaseViewModel.h"
#import "PJTestViewModel.h"
#import "TestTableViewCell.h"
#import "TestModel.h"
#import "ArrayDataSource.h"
#import "PJBaseWebViewController.h"
#import "PJNavAction.h"
#import "PJ.h"
#import "TestCollectionViewController.h"

@interface ViewController ()

//数据请求
@property (strong, nonatomic)PJTestViewModel *pjBaseViewModels;
@property (assign, nonatomic)int count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 1;
//    [self doRequest:nil];
    [self setForbidLoadMore:YES];
    [self setForbidRefresh:YES];
    UINavigationController *nav = [[UINavigationController alloc] init];
    [nav addChildViewController:self];
//    [PJNavAction pushWebVCWithUrl:@"http://gc.ditu.aliyun.com/regeocoding?l=39.938133,116.395739&type=001" title:@"测试"];
//    PJBaseWebViewController *web = [[PJBaseWebViewController alloc] initWithQuery:@{WEB_URL_KEY:@"http://gc.ditu.aliyun.com/regeocoding?l=39.938133,116.395739&type=001",WEB_TITLE:@"测试"}];
//    [self presentViewController:web animated:YES completion:^{
//        
//    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [PJNavAction pushWebVCWithUrl:@"d" title:@"测试"];
//    [self presentViewController:web animated:YES completion:^{
//        
//    }];
//    TestCollectionViewController *test = [[TestCollectionViewController alloc] init];
//    [self presentViewController:test animated:YES completion:^{
//    
//    }];
}

- (void)createDataSource{
    self.dataSource = [ArrayDataSource dataSourceWithItems:self.items];
}

- (NSString *)requestUrl{
    NSLog(@"子类requestUrl");
    return @"http://gc.ditu.aliyun.com/regeocoding?l=39.938133,116.395739&type=001";
}

- (void)requestDidFinishLoad:(id)success failure:(NSError *)failure{
    NSLog(@"success:%@",success);
    //模拟解析完网络返回的数据
    TestModel *m1 = [[TestModel alloc] init];
    m1.hello = @"hello world";
//    if(self.count ==1 ){
//        NSMutableArray *dataArray = [NSMutableArray array];
//        [dataArray addObject:m1];
//        [dataArray addObject:m1];
//        [dataArray addObject:m1];
//        [dataArray addObject:m1];
//        [dataArray addObject:m1];
//        [dataArray addObject:m1];
//        [self addItems:dataArray];
//        self.count++;
//    }else{
//        NSMutableArray *dataArray = [NSMutableArray array];
//        [dataArray addObject:m1];
//        [dataArray addObject:m1];
//        [dataArray addObject:m1];
//        [self addItems:dataArray];
//    }
    NSMutableArray *dataArray = [NSMutableArray array];
    [dataArray addObject:m1];
    [dataArray addObject:m1];
    [dataArray addObject:m1];
    [dataArray addObject:m1];
    [dataArray addObject:m1];
    [dataArray addObject:m1];
    [self addItems:dataArray];
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
