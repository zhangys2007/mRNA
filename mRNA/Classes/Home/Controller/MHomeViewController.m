//
//  MHomeViewController.m
//  mRNA
//
//  Created by zhangys on 2017/6/19.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import "MHomeViewController.h"
#import "MHomeTableViewController.h"

@interface MHomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView * smallTitleView;
@property (nonatomic, strong) NSArray * channelsArray;//频道数组
@property (nonatomic, strong) UIView * redLineView;//红色指示条
@property (nonatomic, strong) UIButton * selectButton;//选中按钮
@property (nonatomic, strong) UIScrollView * scrollView;//内容视图
@property (nonatomic, strong) MHomeTableViewController * tableVC;

@end

@implementation MHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.smallTitleView];
    self.smallTitleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    [self.smallTitleView addSubview:self.redLineView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 153)];
    //    self.scrollView.backgroundColor= RandomColor;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;// 开启分页
    self.scrollView.bounces = NO;// 没有弹簧效果
    self.scrollView.showsHorizontalScrollIndicator = NO;// 隐藏水平滚动条
    [self.view addSubview:self.scrollView];
    
    [self loadSmallTitleData];

}

- (void)loadSmallTitleData{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue:@"1" forKey:@"gender"];
    [dic setValue:@"1" forKey:@"generation"];
    [[MHttpTool shareMHttpTool] get:[URL_BaseUrl stringByAppendingString:GET_V2_channels_preset] parameters:dic success:^(id responseObject) {
        // 将返回的数据转化为对象数组存入当前数组用于设置标题
        NSArray *dictArray = responseObject[@"data"][@"channels"];
        self.channelsArray = [MChannels mj_objectArrayWithKeyValuesArray:dictArray];
        
        [self addSmallTitleView];
        
    } failure:^(NSError * error) {}];
}


- (void)addSmallTitleView{    
    self.scrollView.contentSize = CGSizeMake(self.channelsArray.count * SCREEN_WIDTH, 0);
    
    for (int i = 0; i < self.channelsArray.count; i++) {
        MChannels * channels = self.channelsArray[i];
        
        UIButton * titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.frame = CGRectMake(SCREEN_WIDTH / self.channelsArray.count * i, 0, SCREEN_WIDTH / self.channelsArray.count, 39);
        titleButton.backgroundColor = RandomColor;
        titleButton.tag = 1000 + i;
        [titleButton setTitle:channels.name forState:UIControlStateNormal];
        [titleButton setTitleColor:LightGrayColor forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.smallTitleView addSubview:titleButton];
        
        MHomeTableViewController * tableVC = [[MHomeTableViewController alloc] init];
        [self addChildViewController:tableVC];
        
        if (i == 0) {
            self.selectButton = titleButton;
            [self titleButtonAction:titleButton];
            [self showVc:i];
        }
        
    }

}

// 显示控制器的view
- (void)showVc:(NSInteger)index{
    CGFloat offsetX = index * SCREEN_WIDTH;
    UIViewController *vc = self.childViewControllers[index];
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    [self.scrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, SCREEN_WIDTH, self.scrollView.frame.size.height);
    self.redLineView.frame = CGRectMake(10 + (SCREEN_WIDTH / self.channelsArray.count) * _scrollView.contentOffset.x / SCREEN_WIDTH, 39, SCREEN_WIDTH / self.channelsArray.count - 20, 1);
    MChannels * channels = self.channelsArray[index];
    ((MHomeTableViewController *)vc).chID = channels.channelsID;
}

- (void)titleButtonAction:(UIButton *)sender{
    [self.selectButton setTitleColor:LightGrayColor forState:UIControlStateNormal];
    self.selectButton = sender;
    [self.selectButton setTitleColor:THEMEColor forState:UIControlStateNormal];
    [self.scrollView setContentOffset:CGPointMake((sender.tag - 1000) * SCREEN_WIDTH, 0) animated:YES];
    [self showVc:(sender.tag - 1000)];
}

#pragma mark - UIScrollViewDelegate
//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;{
    NSInteger inte = scrollView.contentOffset.x / SCREEN_WIDTH;

    [self.selectButton setTitleColor:LightGrayColor forState:UIControlStateNormal];
    UIButton * tagButton = (UIButton *)[self.smallTitleView viewWithTag:inte + 1000];
    self.selectButton = tagButton;
    [self.selectButton setTitleColor:THEMEColor forState:UIControlStateNormal];
    
    [self titleButtonAction:self.selectButton];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.redLineView.frame = CGRectMake(10 + (SCREEN_WIDTH / self.channelsArray.count) * _scrollView.contentOffset.x / SCREEN_WIDTH, 39, SCREEN_WIDTH / self.channelsArray.count - 20, 1);
}

#pragma mark - 懒加载
- (UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.backgroundColor = RandomColor;
    }
    return _selectButton;
}

- (UIView *)redLineView{
    if (!_redLineView) {
        _redLineView = [UIView new];
        _redLineView.backgroundColor = THEMEColor;
    }
    return _redLineView;
}

- (NSArray *)channelsArray{
    if(!_channelsArray) {
        _channelsArray = [NSArray array];
    }
    return _channelsArray;
}

- (UIView *)smallTitleView{
    if (!_smallTitleView) {
        _smallTitleView = [UIView new];
        _smallTitleView.backgroundColor = White250Color;
    }
    return _smallTitleView;
}

@end
