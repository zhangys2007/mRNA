//
//  MHttpTool.h
//  mRNA
//
//  Created by zhangys on 2017/6/19.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHttpTool : NSObject<NSCopying>

+ (instancetype)shareMHttpTool;

- (void)get:( NSString *)URLString
        parameters:( id)parameters
        success:( void (^)(id  responseObject))success
        failure:( void (^)(NSError * error))failure;

- (void)post:( NSString *)URLString
        parameters:( id)parameters
        success:( void (^)(id  responseObject))success
        failure:(void (^)(NSError * error))failure;

@end
