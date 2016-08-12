//
//  PJTableViewController.m
//  PJ
//
//  Created by piaojin on 16/7/27.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJTableViewController.h"
#import "PJBaseTableViewDataSource.h"
#import "PJBaseTableViewCell.h"
#import "ArrayDataSource.h"

@interface PJTableViewController ()

@end

@implementation PJTableViewController

- (void)dealloc {
    [self setDataSource:nil];
    [self setTableView:nil];
}

- (id)initWithQuery:(NSDictionary *)query {
    self = [super initWithQuery:query];
    if (self) {
        self.page = 1;
        self.items = [NSMutableArray arrayWithCapacity:0];
        self.pullLoadType = PullDefault;
        _loadMoreEnable = YES;
        _loadRefreshEnable = YES;
        _forbidLoadMore = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    [self initFreshView];
}
//子类重写
- (void)createDataSource {
    
}

- (void)setDataSource:(id <PJBaseTableViewDataSource>)dataSource{
    if(dataSource){
        _dataSource = dataSource;
        _tableView.dataSource = _dataSource;
        [_tableView reloadData];
    }
}

#pragma  数据请求相关

- (void)didFinishLoad:(id)success failure:(NSError *)failure {
    [self endRefreshing];
    [super didFinishLoad:success failure:failure];
}

- (void)didFailLoadWithError:(NSError *)failure{
    if (self.pullLoadType == PullUpLoadMore) {
        self.page--;
    }
    [self endRefreshing];
    [super didFailLoadWithError:failure];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id <PJBaseTableViewDataSource> dataSource = (id <PJBaseTableViewDataSource>) tableView.dataSource;
    id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    Class cls = [dataSource tableView:tableView cellClassForObject:object];
    return [cls tableView:tableView rowHeightForObject:object];
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    id <PJBaseTableViewDataSource> dataSource = (id <PJBaseTableViewDataSource>) tableView.dataSource;
    id object = [dataSource tableView:tableView objectForRowAtIndexPath:indexPath];
    [self didSelectObject:object atIndexPath:indexPath];
}

//cell 点击跳转方法
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark PJErrorViewDelegate
- (void)refreshBtnClicked{
    [self refreshForNewData];
}

- (void)tabClickrefreshData {
    if (self.isLoading) {
        return;
    }
    [self autoPullDown];
}

#pragma 上下拉刷新相关
//初始化刷新控件
- (void)initFreshView{
    //下拉刷新
    _tableView.mj_header = self.freshHeader;
    //上拉加载更多
    _tableView.mj_footer = self.freshFooter;
    _loadRefreshEnable = YES;
    _loadMoreEnable = YES;
    _forbidLoadMore = NO;
    self.page = 1;
}

- (void)onDataUpdated{
    [super onDataUpdated];
    [self createDataSource];
    [self handleWhenLessOnePage];
    [self handleWhenNoneData];
    [self setPullEndStatus];
}

- (void)onLoadFailed {
    [super onLoadFailed];
    [self setPullFailedStatus];
}

- (void)setPullEndStatus {
    if (self.pullLoadType == PullUpLoadMore) {
        [self endLoadMore];
    }else {
        [self performSelector:@selector(endRefresh) withObject:nil afterDelay:0.62];
    }
}

- (void)setPullFailedStatus{
    [self setPullEndStatus];
}

- (void)handleWhenLessOnePage {
    if(!_forbidLoadMore){
        if ((self.items.count < self.limit && self.page == 1) || (self.newItemsCount < self.limit && self.page >= 2) || self.items.count <= 0 ||self.newItemsCount <= 0) {
            [self setLoadMoreEnable:NO];
        }else{
            [self setLoadMoreEnable:YES];
        }
    }
}

- (void)emptyUrl{
    NSLog(@"url为空！");
    [self endRefreshing];
}

//如果无数据则进行处理
- (void)handleWhenNoneData{
    if(self.page == 1 && self.items.count <= 0){
        //没有数据
        [self showEmpty:YES];
    }else{
        [self showEmpty:NO];
    }
}

- (void)endRefreshing{
    if (self.pullLoadType == PullDownRefresh) {
        [self endRefresh];
    }else if(self.pullLoadType == PullUpLoadMore){
        [self endLoadMore];
    }
}

- (void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    self.isLoading = NO;
    if (self.pullLoadType != PullUpLoadMore) {
        self.pullLoadType = PullDefault;
    }
}

- (void)endLoadMore{
    [self.tableView.mj_footer endRefreshing];
    self.isLoading = NO;
    self.pullLoadType = PullDefault;
    self.isPullingUp = NO;
}

//直接调用自动下拉刷新
- (void)autoPullDown{
    [self refreshForNewData];
}

//更新了新数据
- (void)refreshForNewData {
    self.isLoading = YES;
    self.pullLoadType = PullDownRefresh;
    self.page = 1;
    [self.items removeAllObjects];
    [self doRequest:self.way];
}

//在下拉刷新之前可以处理的事
- (void)beforePullDownRefreshing{
    
}

//在上拉刷新之前可以处理的事
- (void)beforePullUpLoading{
    
}

//下拉刷新
- (void)beginPullDownRefreshing{
    if([self canPullDownRefreshed]){
        [self beforePullDownRefreshing];
        [self refreshForNewData];
    }
}

//上拉刷新
- (void)beginPullUpLoading{
    [self beforePullUpLoading];
    self.isLoading = YES;
    self.isPullingUp = YES;
    self.pullLoadType = PullUpLoadMore;
    self.page ++;
    [self doRequest:self.way];
}

- (BOOL)canPullDownRefreshed{
    return [self loadRefreshEnable];
}

- (BOOL)canPullUpLoadMore{
    return [self loadMoreEnable];
}

- (void)setLoadMoreEnable:(BOOL)loadMoreEnable{
    [self.tableView.mj_footer setHidden:!loadMoreEnable];
    _loadMoreEnable = loadMoreEnable;
}

- (void)setLoadRefreshEnable:(BOOL)loadRefreshEnable{
    [self.tableView.mj_header setHidden:!loadRefreshEnable];
    _loadRefreshEnable = loadRefreshEnable;
}

- (void)setForbidLoadMore:(BOOL)forbidLoadMore{
    [self.tableView.mj_footer setHidden:forbidLoadMore];
    _forbidLoadMore = forbidLoadMore;
}

- (void)setForbidRefresh:(BOOL)forbidRefresh{
    [self.tableView.mj_header setHidden:forbidRefresh];
}

#pragma setter,getter

- (UITableView *)tableView{
    if (nil == _tableView){
        _tableView = [[UITableView alloc] initWithFrame:[self tableViewFrame] style:[self tableViewStyle]];
        _tableView.backgroundColor = [self.view backgroundColor];
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UITableViewStyle)tableViewStyle{
    return UITableViewStylePlain;
}

- (CGRect)tableViewFrame{
    CGRect rect = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    return rect;
}

- (MJRefreshNormalHeader *)freshHeader{
    if(!_freshHeader){
        _freshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginPullDownRefreshing)];
    }
    return _freshHeader;
}

- (MJRefreshAutoNormalFooter *)freshFooter{
    if(!_freshFooter){
        _freshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(beginPullUpLoading)];
    }
    return _freshFooter;
}

@end
