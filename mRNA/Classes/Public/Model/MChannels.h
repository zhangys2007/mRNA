//
//  MChannels.h
//  mRNA
//
//  Created by zhangys on 2017/6/21.
//  Copyright © 2017年 上海永同资产管理有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MChannels : NSObject

/**
 *  id
 */
@property (nonatomic, assign) NSInteger channelsID;

/**
 *  eidtable
 */
@property (nonatomic, assign) NSInteger editable;

/**
 * name
 */
@property (nonatomic, copy) NSString * name;

@end
