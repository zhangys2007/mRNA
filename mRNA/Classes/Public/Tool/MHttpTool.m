//
//  MHttpTool.m
//  mRNA
//
//  Created by zhangys on 2017/6/19.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import "MHttpTool.h"

@interface MHttpTool ()

@end

@implementation MHttpTool

+ (void)initialize {
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
}

#pragma mark - 单例
static id _instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareMHttpTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

#pragma mark - 工具类方法

/**
 *  加载数据
 */
- (void)get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id _Nullable responseObject))success failure:(void (^)(NSError *error))failure {
    [[AFHTTPSessionManager manager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 回调成功之后的block
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 回调失败之后的block
        failure(error);
    }];
}

- (void)post:(NSString *)URLString parameters:(id)parameters success:(void (^)(id _Nullable responseObject))success failure:(void (^)(NSError *error))failure {
    
    [[AFHTTPSessionManager manager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 回调成功之后的block
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 回调失败之后的block
        failure(error);
    }];
}




@end
