//
//  MMainViewController.m
//  mRNA
//
//  Created by zhangys on 2017/6/19.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import "MMainViewController.h"
#import "MHomeViewController.h"
#import "MGoodsViewController.h"
#import "MSortViewController.h"

@interface MMainViewController ()<UITabBarControllerDelegate>

@end

@implementation MMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor = WhiteColor;
    self.delegate = self;
    
    MHomeViewController * homeVC = [[MHomeViewController alloc] init];
    homeVC.title = @"首页";
    UINavigationController * homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeNav.navigationBar.translucent = NO;
    
    MGoodsViewController * goodsVC = [[MGoodsViewController alloc] init];
    goodsVC.title = @"单品";
    UINavigationController * goodsNav = [[UINavigationController alloc] initWithRootViewController:goodsVC];
    goodsNav.navigationBar.translucent = NO;
    
    MSortViewController * sortVC = [[MSortViewController alloc] init];
    sortVC.title = @"分类";
    UINavigationController * sortNav = [[UINavigationController alloc] initWithRootViewController:sortVC];
    sortNav.navigationBar.translucent = NO;
    
    self.viewControllers = @[homeNav,goodsNav,sortNav];
    
    NSArray * iconArray = @[@"tabbar_icon_home",@"tabbar_icon_goods",@"tabbar_icon_sort"];
    NSArray * selectedIconArray = @[@"tabbar_icon_home_select",@"tabbar_icon_goods_select",@"tabbar_icon_sort_select"];
    for (int i = 0; i < self.viewControllers.count; i++) {
        UINavigationController * nav = [self.viewControllers objectAtIndex:i];
        nav.tabBarItem.image = [[UIImage imageNamed:[iconArray objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:[selectedIconArray objectAtIndex:i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //[nav.tabBarItem setImageInsets:UIEdgeInsetsMake(-3.0, 0.0, 3.0, 0.0)];
    }
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont   systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blackColor]}   forState:UIControlStateNormal];
    
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:THEMEColor} forState:UIControlStateSelected];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
