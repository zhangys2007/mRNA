//
//  MChannels.m
//  mRNA
//
//  Created by zhangys on 2017/6/21.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import "MChannels.h"

@implementation MChannels

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"channelsID"] = @"id";
    return dic;
}

@end
