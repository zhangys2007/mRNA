//
//  MHomeTableViewController.m
//  mRNA
//
//  Created by zhangys on 2017/6/23.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import "MHomeTableViewController.h"
#import "MItem.h"
#import "MHomeCell.h"
#import "MDetailViewController.h"

@interface MHomeTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * itemArray;//频道数组
@property (nonatomic, copy) NSString * next_url;//下一页的请求地址

@end

@implementation MHomeTableViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData:self.chID];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        if (self.next_url) {
            [self loadMoreData:self.next_url];
        }
    }];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
    [self.tableView.mj_footer beginRefreshing];
}

- (void)loadNewData:(NSInteger)channesID{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"1" forKey:@"gender"];
    [dic setValue:@"1" forKey:@"generation"];
    [dic setValue:@"20" forKey:@"limit"];
    [dic setValue:@"0" forKey:@"offset"];
    
    [[MHttpTool shareMHttpTool] get:[URL_BaseUrl stringByAppendingString:[NSString stringWithFormat:@"/v1/channels/%ld/items", channesID]] parameters:dic success:^(id responseObject) {
        NSArray *dictArr = responseObject[@"data"][@"items"];
        self.itemArray = [MItem mj_objectArrayWithKeyValuesArray:dictArr];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        self.next_url = responseObject[@"data"][@"paging"][@"next_url"];
    } failure:^(NSError * error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData:(NSString *)urlStr{
    [[MHttpTool shareMHttpTool] get:urlStr parameters:nil success:^(id responseObject) {
        NSArray *dictArr = responseObject[@"data"][@"items"];
        NSMutableArray * item = [MItem mj_objectArrayWithKeyValuesArray:dictArr];
        [self.itemArray addObjectsFromArray:item];

        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError * error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * homecell = @"MhomeCell";
    MHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:homecell];
    if (!cell) {
        cell = [[MHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:homecell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.itemArray.count > 0) {
        MItem * item = self.itemArray[indexPath.row];
        cell.titleLabel.text = item.title;
        [cell.bgImage sd_setImageWithURL:[NSURL URLWithString:item.cover_image_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MItem * item = self.itemArray[indexPath.row];
    MDetailViewController * detaulVC = [[MDetailViewController alloc] init];
    detaulVC.item = item;
    [self pushViewController:detaulVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}


- (NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RandomColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
