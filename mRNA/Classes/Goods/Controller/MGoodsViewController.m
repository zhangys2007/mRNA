//
//  MGoodsViewController.m
//  mRNA
//
//  Created by zhangys on 2017/6/19.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import "MGoodsViewController.h"
#import "MGoodsViewCell.h"
#import "MGoodsModel.h"
#import "MGoodsDetailViewController.h"

@interface MGoodsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * goodsArray;
@property (nonatomic, copy) NSString * next_url;

@end

@implementation MGoodsViewController

static NSString * const collectionCellID = @"collectionCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[MGoodsViewCell class] forCellWithReuseIdentifier:collectionCellID];
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    [self.collectionView.mj_header beginRefreshing];
    
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        if (self.next_url) {
            [self loadMoreData:self.next_url];
        }
    }];
    self.collectionView.mj_footer.automaticallyChangeAlpha = YES;
    [self.collectionView.mj_footer beginRefreshing];
    

}

- (void)loadNewData{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"1" forKey:@"gender"];
    [dic setValue:@"2" forKey:@"generation"];
    [dic setValue:@"20" forKey:@"limit"];
    [dic setValue:@"0" forKey:@"offset"];
    
    [[MHttpTool shareMHttpTool] get:[URL_BaseUrl stringByAppendingString:[NSString stringWithFormat:@"/v2/items"]] parameters:dic success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *dicts = responseObject[@"data"][@"items"];
        for (NSDictionary *dic in dicts) {
            MGoodsModel * product = [MGoodsModel mj_objectWithKeyValues:dic[@"data"]];
            [self.goodsArray addObject:product];
        }
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        self.next_url = responseObject[@"data"][@"paging"][@"next_url"];
    } failure:^(NSError * error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData:(NSString *)urlStr{
    [[MHttpTool shareMHttpTool] get:urlStr parameters:nil success:^(id responseObject) {
        NSArray *dictArr = responseObject[@"data"][@"items"];
        for (NSDictionary *dic in dictArr) {
            MGoodsModel * product = [MGoodsModel mj_objectWithKeyValues:dic[@"data"]];
            [self.goodsArray addObject:product];
        }
        
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSError * error) {
        [self.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MGoodsViewCell * cell = [_collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor purpleColor];
    if (self.goodsArray.count > 0) {
        MGoodsModel * goodsModel = self.goodsArray[indexPath.row];
        [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.cover_image_url] completed:^(UIImage * image, NSError * error, SDImageCacheType cacheType, NSURL * imageURL) {
        }];
        cell.titleLabel.text = goodsModel.name;
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",goodsModel.price];
    }
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIDTH - 20) / 2, 245);
}

#pragma mark ---- UICollectionViewDelegate
// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MGoodsModel * goodsModel = self.goodsArray[indexPath.row];
    MGoodsDetailViewController * goods = [[MGoodsDetailViewController alloc] init];
    goods.goodsModel = goodsModel;
    [self pushViewController:goods animated:YES];
}

#pragma mark - lazy load
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _collectionView.backgroundColor =RandomColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSMutableArray *)goodsArray{
    if(!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}

@end
