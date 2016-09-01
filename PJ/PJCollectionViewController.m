//
//  PJCollectionViewController.m
//  Created by piaojin on 16/7/29.
//  Copyright © 2016年 piaojin. All rights reserved.
//

#import "PJCollectionViewController.h"
#import "PJCollectionViewHeaderView.h"
#import "PJCollectionViewFooterView.h"
#import "PJCollectionViewLayout.h"
#import "MJRefresh.h"

@implementation PJCollectionViewController
- (void)dealloc {
    [self setDataSource:nil];
    [self setCollectionView:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.page = 1;
        self.items = [NSMutableArray arrayWithCapacity:0];
        self.pullLoadType = PullDefault;
        
        _loadMoreEnable = YES;
        _loadRefreshEnable = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self collectionView];
    [self setCollectionLayout];
    [self initFreshView];
}

- (void)setDataSource:(id <PJCollectionViewDataSource>)dataSource{
    if (dataSource != _dataSource) {
        _dataSource = dataSource;
        _collectionView.dataSource = _dataSource;
        [_collectionView reloadData];
    }
}

#pragma 上下拉刷新相关
//初始化刷新控件
- (void)initFreshView{
    
    // 下拉刷新
    self.collectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginPullDownRefreshing)];
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(beginPullUpLoading)];
    // 默认先隐藏footer
    self.collectionView.mj_footer.hidden = YES;
    _forbidLoadMore = NO;
}

- (void)endRefreshing{
    if (self.pullLoadType == PullDownRefresh) {
        [self endRefresh];
    }else if(self.pullLoadType == PullUpLoadMore){
        [self endLoadMore];
    }
}

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

- (void)createDataSource {
    
}

//controller直接调用自动下拉刷新
- (void)autoPullDown{
    [self refreshForNewData];
}

//更新了新数据
- (void)refreshForNewData {
    self.pullLoadType = PullDownRefresh;
    self.page = 1;
    [self.items removeAllObjects];
    [self doRequest:self.way];
}

#pragma mark- collectionView

- (UICollectionView *)collectionView {
    if (nil == _collectionView){
        PJCollectionViewLayout *layout = [[PJCollectionViewLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:[self collectionViewFrame] collectionViewLayout:layout];
        _collectionView.backgroundColor = [self.view backgroundColor];
        [self.view addSubview:_collectionView];
        _collectionView.delegate = self;
        _collectionView.alwaysBounceVertical = YES;
        [self collectionViewRegisterCellClassAndReuseIdentifier];
    }
    return _collectionView;
}

//初始化注册cell&Identifier（多种）
- (void)collectionViewRegisterCellClassAndReuseIdentifier {
    [_collectionView registerClass:[PJCollectionViewCell class] forCellWithReuseIdentifier:@"PJCollectionViewCell"];
    [self.collectionView registerClass:[PJCollectionViewHeaderView class]  forSupplementaryViewOfKind:PJCollectionViewHeader withReuseIdentifier:@"PJCollectionViewHeader"];
    [self.collectionView registerClass:[PJCollectionViewFooterView class]  forSupplementaryViewOfKind:PJCollectionViewFooter withReuseIdentifier:@"PJCollectionViewFooter"];
}

- (CGRect)collectionViewFrame {
    return [self.view bounds];
}

#pragma mark- UICollectionViewDelegateFlowLayout
- (void)setCollectionLayout{
    NSMutableArray *numOfRowsMuti = [self numOfRowsMuti];
    if (!numOfRowsMuti) {
        numOfRowsMuti = [NSMutableArray arrayWithObject:[NSNumber numberWithUnsignedLong:[self numOfRows]]];
    }
    self.layout.numberOfItemsPerLines = numOfRowsMuti;
    
    NSMutableArray *XPaddingMuti = [self XPaddingMuti];
    if (!XPaddingMuti) {
        XPaddingMuti = [NSMutableArray arrayWithObject:[NSNumber numberWithUnsignedLong:[self XPadding]]];
    }
    self.layout.XSpacings = XPaddingMuti;
    
    NSMutableArray *YPaddingMuti = [self YPaddingMuti];
    if (!YPaddingMuti) {
        YPaddingMuti = [NSMutableArray arrayWithObject:[NSNumber numberWithUnsignedLong:[self YPadding]]];
    }
    self.layout.YSpacings = YPaddingMuti;

    NSMutableArray *layoutEdgeInsetsMuti = [self layoutEdgeInsetsMuti];
    if (!layoutEdgeInsetsMuti) {
        NSString *string = NSStringFromUIEdgeInsets([self layoutEdgeInsets]);
        layoutEdgeInsetsMuti = [NSMutableArray arrayWithObject:string];
    }
    self.layout.sectionInsets = layoutEdgeInsetsMuti;
}

#pragma mark- default one section
//设置collectionView的内容有几列
- (NSUInteger)numOfRows{
    return 2;
}

//列间距
- (CGFloat)XPadding{
    return 5.f;
}

//行间距
- (CGFloat)YPadding{
    return 5.f;
}

//设置collectionView的前后左右的间距
- (UIEdgeInsets)layoutEdgeInsets{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - muti sections
//设置collectionView的内容有几列
- (NSMutableArray *)numOfRowsMuti{
    return nil;
}

//列间距
- (NSMutableArray *)XPaddingMuti{
    return nil;
}

//行间距
- (NSMutableArray *)YPaddingMuti{
    return nil;
}

- (NSMutableArray *)layoutEdgeInsetsMuti{
    return nil;
}

- (PJCollectionViewLayout *)layout
{
    return (id)self.collectionView.collectionViewLayout;
}

//cell 点击跳转方法
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    
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

- (void)handleWhenNoneData{

}

- (void)setLoadMoreEnable:(BOOL)loadMoreEnable{
    [self.collectionView.mj_footer setHidden:!loadMoreEnable];
    _loadMoreEnable = loadMoreEnable;
}

- (void)setLoadRefreshEnable:(BOOL)loadRefreshEnable{
     [self.collectionView.mj_header setHidden:!loadRefreshEnable];
    _loadRefreshEnable = loadRefreshEnable;
}

- (void)setForbidLoadMore:(BOOL)forbidLoadMore{
    [self.collectionView.mj_footer setHidden:forbidLoadMore];
    _forbidLoadMore = forbidLoadMore;
}

- (void)setForbidRefresh:(BOOL)forbidRefresh{
    [self.collectionView.mj_header setHidden:forbidRefresh];
}

- (void)endRefresh{
    if (self.pullLoadType != PullUpLoadMore) {
        self.pullLoadType = PullDefault;
    }
    [self.collectionView.mj_header endRefreshing];
}

- (void)endLoadMore{
    self.pullLoadType = PullDefault;
    [self.collectionView.mj_footer endRefreshing];
    self.isPullingUp = NO;
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [_collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    id <PJCollectionViewDataSource> dataSource = (id <PJCollectionViewDataSource>) collectionView.dataSource;
    id object = [dataSource collectionView:collectionView objectForRowAtIndexPath:indexPath];
    [self didSelectObject:object atIndexPath:indexPath];
}

- (BOOL)keepiOS7NewApiCharacter{
    //tableview.top 已设置，忽略
    return NO;
}

- (void)beginPullDownRefreshing{
    if([self canPullDownRefreshed]){
        [self refreshForNewData];
    }
}

- (void)beginPullUpLoading{
    self.isPullingUp = YES;
    self.pullLoadType = PullUpLoadMore;
    self.page ++;
    [self doRequest:self.way];
}

- (BOOL)canPullDownRefreshed{
    return _loadRefreshEnable;
}

- (BOOL)canPullUpLoadMore{
    return _loadMoreEnable;
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

- (int)limit{
    return 6;
}

@end
