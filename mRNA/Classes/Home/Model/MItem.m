//
//  MItem.m
//  mRNA
//
//  Created by zhangys on 2017/6/21.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import "MItem.h"

@implementation MItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"itemID"] = @"id";
    return dict;
}

@end
