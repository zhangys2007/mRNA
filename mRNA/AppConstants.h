//
//  AppConstants.h
//  mRNA
//
//  Created by zhangys on 2017/6/19.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RootViewController.h"
#import "AFNetworking.h"
#import "IQKeyboardManager.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "ZJScrollPageView.h"
#import "MHttpTool.h"
#import "MChannels.h"


//测试URL
#define URL_BaseUrl    @"http://api.dantangapp.com"


//接口
#define GET_V2_channels_preset            @"/v2/channels/preset"//首页 小标题

//背景色设置
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]
//#define RandomColor [UIColor clearColor]
#define THEMEColor [UIColor colorWithRed:216/255.0 green:30/255.0 blue:6/255.0 alpha:1] //主题色(红色)
#define White250Color [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1] 
#define WhiteColor     [UIColor whiteColor]
#define LightGrayColor [UIColor lightGrayColor]
#define RedColor [UIColor redColor]


//字体设置
#define FONT12 [UIFont systemFontOfSize:12 * autoSizeScaleX]
#define FONT14 [UIFont systemFontOfSize:14 * autoSizeScaleX]
#define FONT16 [UIFont systemFontOfSize:16 * autoSizeScaleX]
#define FONT18 [UIFont systemFontOfSize:18 * autoSizeScaleX]
#define FONT20 [UIFont systemFontOfSize:20 * autoSizeScaleX]
#define FONT25 [UIFont systemFontOfSize:25 * autoSizeScaleX]
#define FONT40 [UIFont systemFontOfSize:40 * autoSizeScaleX]


//设备信息
#define Parameter_systemVersion [[UIDevice currentDevice] systemVersion]
#define Parameter_appversion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define DeviceName [NSString stringWithFormat:@"%@_%@_%@",[[UIDevice currentDevice] name],[[UIDevice currentDevice] model],[[UIDevice currentDevice] systemVersion]]
#define YTAPPVERSION [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] // app 版本
#define YT_APP_VERSION [[MHAOAPPVERSION stringByReplacingOccurrencesOfString:@"." withString:@""] intValue] // app 版本


//屏幕尺寸
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_FRAME [UIScreen mainScreen].bounds

//尺寸比例数据 [7 PLUS]
#define autoSizeScaleX SCREEN_WIDTH / 414.0f
#define autoSizeScaleY SCREEN_HEIGHT / 736.0f

#define string_Value(string) [NSString stringWithFormat:@"%@",string]
//mhao 常量
#define is_iPhone4 SCREEN_HEIGHT == 480




#endif /* AppConstants_h */
