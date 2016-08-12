# PJ
**快速开发架构**
PJBaseModelViewController 普通网络请求，不包含tableView操作，
PJTableViewController（包含tableView,集成分页，刷新），
PJCollectionViewController（包含CollectionView,集成分页，刷新）。

#用法
##1.[self doRequest:@"GET或POST"];
##2.重写
- (void)createDataSource{
    self.dataSource = [ArrayDataSource dataSourceWithItems:self.items];//设置数据源
}
//设置请求url
- (NSString *)requestUrl{
    return @"http://gc.ditu.aliyun.com/regeocoding?l=39.938133,116.395739&type=001";
}
如果有参数重写
- (NSMutableDictionary *)params{
}
如果有自己的viewModel（必须继承PJBaseViewModel）重写
//子类重写
- (PJBaseViewModel *)pjBaseViewModel{
    
}
##3.重写请求后的回调
- (void)requestDidFinishLoad:(id)success failure:(NSError *)failure{
//在这边可以处理返回的数据
}
- (void)requestDidFailLoadWithError:(NSError *)failure{
}
##4.如果数据源（表格和网格的类似）对应的cell比较特殊可以重写数据源（必须继承PJBaseTableViewDataSource）
@interface ArrayDataSource : PJBaseTableViewDataSource

@end
/**
 *子类可以重写，已达到子类的要求
 *
 */
#pragma PJBaseTableViewDataSource 代理
- (id)tableView:(UITableView *)tableView objectForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
//返回数据源所对应的cell的类型（一般重写改方法即可）
- (Class)tableView:(UITableView *)tableView cellClassForObject:(id)model{
    if(model && [model isKindOfClass:[TestModel class]]){
        return [TestTableViewCell class];
    }
    return [super tableView:tableView cellClassForObject:model];
}

- (NSIndexPath *)tableView:(UITableView *)tableView indexPathForObject:(id)object{
    return [self tableView:tableView indexPathForObject:object];
}

- (void)tableView:(UITableView *)tableView cell:(UITableViewCell *)cell willAppearAtIndexPath:(NSIndexPath *)indexPath{
}
##5.如果是多组表格或网格则需要去重写更多的内容，具体可看源码注释，可以通过子类重写达到适应子类的要求。
    
}
