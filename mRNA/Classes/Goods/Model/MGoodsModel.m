//
//  MGoodsModel.m
//  mRNA
//
//  Created by zhangys on 2017/6/27.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import "MGoodsModel.h"

@implementation MGoodsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"goodsID"] = @"id";
    dict[@"describe"] = @"description";
    return dict;
}

@end
